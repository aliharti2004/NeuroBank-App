import numpy as np
import pandas as pd
from flask import Flask, request, jsonify
from flask_cors import CORS
import joblib
import os
from datetime import datetime

app = Flask(__name__)
CORS(app)  # Permet les requetes depuis Java

# Configuration
MODEL_PATH = os.path.join('models', 'modele_regression_logistique.joblib')
SCALER_PATH = os.path.join('models', 'scaler_banque.joblib')
ENCODER_VILLE_PATH = os.path.join('models', 'encoder_ville.joblib')
ENCODER_TYPE_PATH = os.path.join('models', 'encoder_type.joblib')
FEATURES_PATH = os.path.join('models', 'feature_names.joblib')

# Chargement du modele et des preprocesseurs au demarrage
print("Initialisation de l'API...")
print("Chargement du modele de regression logistique...")

try:
    model = joblib.load(MODEL_PATH)
    scaler = joblib.load(SCALER_PATH)
    encoder_ville = joblib.load(ENCODER_VILLE_PATH)
    encoder_type = joblib.load(ENCODER_TYPE_PATH)
    feature_names = joblib.load(FEATURES_PATH)
    print("Modele, scaler et encodeurs charges avec succes!")
    print(f"Features: {feature_names}")
    print(f"Villes: {list(encoder_ville.classes_)}")
    print(f"Types: {list(encoder_type.classes_)}")
except Exception as e:
    print(f"ERREUR lors du chargement: {e}")
    model = None
    scaler = None
    encoder_ville = None
    encoder_type = None
    feature_names = None


def preprocesser_donnees(data):
    """
    Pretraite les donnees recues de l'application Java
    
    Args:
        data: dict contenant les donnees de la demande de pret
        
    Returns:
        numpy array pret pour la prediction
    """
    try:
        # Extraction des donnees
        revenu = float(data.get('revenu', 0))
        mensualite = float(data.get('mensualite', 0))  # C'est le remboursement mensuel
        duree = int(data.get('duree', 0))
        taux = float(data.get('taux', 0))
        ville = data.get('ville', 'PARIS').upper()
        type_pret = data.get('type_pret', 'immobilier').lower()
        
        # Encodage des variables categorielles avec les LabelEncoders
        try:
            ville_encoded = encoder_ville.transform([ville])[0]
        except:
            # Si ville inconnue, utiliser PARIS par defaut (index 4)
            print(f"Ville inconnue: {ville}, utilisation de PARIS par defaut")
            ville_encoded = encoder_ville.transform(['PARIS'])[0]
        
        try:
            type_encoded = encoder_type.transform([type_pret])[0]
        except:
            # Si type inconnu, utiliser immobilier par defaut (index 1)
            print(f"Type inconnu: {type_pret}, utilisation de immobilier par defaut")
            type_encoded = encoder_type.transform(['immobilier'])[0]
        
        # Creation du DataFrame avec les features dans le bon ordre
        # ['revenu', 'remboursement', 'duree', 'taux', 'ville_encoded', 'type_encoded']
        features_dict = {
            'revenu': revenu,
            'remboursement': mensualite,
            'duree': duree,
            'taux': taux,
            'ville_encoded': ville_encoded,
            'type_encoded': type_encoded
        }
        
        df = pd.DataFrame([features_dict], columns=feature_names)
        
        # Normalisation avec le scaler
        X_scaled = scaler.transform(df)
        
        return X_scaled, features_dict
        
    except Exception as e:
        print(f"Erreur lors du pretraitement: {str(e)}")
        raise


def calculer_score_risque(probabilite):
    """
    Convertit la probabilite en score de risque (0-100)
    Plus le score est eleve, plus le risque est eleve
    
    Args:
        probabilite: probabilite de defaut (0-1)
        
    Returns:
        score de risque (0-100)
    """
    return int(probabilite * 100)


def generer_recommandation(score_risque, probabilite, donnees):
    """
    Genere une recommandation textuelle basee sur le score de risque
    
    Args:
        score_risque: score de risque (0-100)
        probabilite: probabilite de defaut
        donnees: donnees du pret
        
    Returns:
        str: recommandation pour l'agent
    """
    ratio = (donnees['remboursement'] / donnees['revenu']) * 100 if donnees['revenu'] > 0 else 100
    reste_vivre = donnees['revenu'] - donnees['remboursement']
    
    if score_risque < 30:
        return (f"RISQUE FAIBLE ({score_risque}/100) - Profil client excellent. "
                f"Ratio d'endettement: {ratio:.1f}%. Reste a vivre: {reste_vivre:.0f} EUR. "
                f"Validation recommandee.")
    elif score_risque < 50:
        return (f"RISQUE MODERE ({score_risque}/100) - Profil acceptable avec quelques reserves. "
                f"Ratio d'endettement: {ratio:.1f}%. Reste a vivre: {reste_vivre:.0f} EUR. "
                f"Analyse complementaire suggeree.")
    elif score_risque < 70:
        return (f"RISQUE ELEVE ({score_risque}/100) - Profil a risque. "
                f"Ratio d'endettement: {ratio:.1f}%. Reste a vivre: {reste_vivre:.0f} EUR. "
                f"Validation conditionnelle ou refus recommande.")
    else:
        return (f"RISQUE TRES ELEVE ({score_risque}/100) - Profil tres risque. "
                f"Ratio d'endettement: {ratio:.1f}%. Reste a vivre: {reste_vivre:.0f} EUR. "
                f"Refus fortement recommande.")


@app.route('/predict', methods=['POST'])
def predict():
    """
    Endpoint principal pour la prediction de risque de pret
    
    Recoit les donnees du client et de la demande
    Retourne la prediction avec score et recommandation
    """
    try:
        if model is None:
            return jsonify({
                'error': 'Modele non charge',
                'scoreRisque': 0,
                'probabiliteDefaut': 0,
                'recommandation': 'ERREUR: Modele ML non disponible'
            }), 500
        
        # Recuperation des donnees JSON
        data = request.get_json()
        
        if not data:
            return jsonify({
                'error': 'Aucune donnee fournie'
            }), 400
        
        print(f"Donnees recues: {data}")
        
        # Pretraitement des donnees
        X, donnees_cleaned = preprocesser_donnees(data)
        
        # Prediction avec le modele
        # predict_proba retourne [proba_classe_0, proba_classe_1]
        # On veut la probabilite de la classe 1 (risque eleve)
        prediction_proba = model.predict_proba(X)
        probabilite_defaut = float(prediction_proba[0][1])
        
        # Calcul du score de risque
        score_risque = calculer_score_risque(probabilite_defaut)
        
        # Generation de la recommandation
        recommandation = generer_recommandation(score_risque, probabilite_defaut, donnees_cleaned)
        
        # Determination de la classe
        classe_risque = "RISQUE_ELEVE" if probabilite_defaut >= 0.5 else "RISQUE_FAIBLE"
        
        # Preparation de la reponse
        response = {
            'scoreRisque': score_risque,
            'probabiliteDefaut': round(probabilite_defaut, 4),
            'recommandation': recommandation,
            'classeRisque': classe_risque,
            'timestamp': datetime.now().isoformat()
        }
        
        print(f"Reponse: {response}")
        
        return jsonify(response), 200
        
    except Exception as e:
        error_msg = f"Erreur lors de la prediction: {str(e)}"
        print(f"ERREUR: {error_msg}")
        return jsonify({
            'error': error_msg,
            'scoreRisque': 0,
            'probabiliteDefaut': 0,
            'recommandation': f'ERREUR IA: {error_msg}'
        }), 500


@app.route('/health', methods=['GET'])
def health_check():
    """
    Endpoint de verification de l'etat du service
    """
    model_status = 'loaded' if model is not None else 'not loaded'
    return jsonify({
        'status': 'healthy',
        'model': 'Logistic Regression (scikit-learn)',
        'modelStatus': model_status,
        'accuracy': '95.92%',
        'version': '1.0',
        'timestamp': datetime.now().isoformat()
    }), 200


@app.route('/model-info', methods=['GET'])
def model_info():
    """
    Retourne les informations sur le modele charge
    """
    if model is None:
        return jsonify({'error': 'Modele non charge'}), 500
    
    return jsonify({
        'modelType': 'Logistic Regression',
        'framework': 'scikit-learn',
        'pythonVersion': '3.14',
        'accuracy': '95.92%',
        'trainSize': 195,
        'testSize': 49,
        'features': feature_names,
        'scalerType': 'StandardScaler',
        'encoderType': 'LabelEncoder'
    }), 200


@app.route('/test-predict', methods=['GET'])
def test_predict():
    """
    Endpoint de test avec des donnees exemple
    """
    test_data = {
        'revenu': 5000,
        'mensualite': 1200,
        'duree': 240,
        'taux': 1.5,
        'ville': 'PARIS',
        'type_pret': 'immobilier'
    }
    
    try:
        if model is None:
            return jsonify({'error': 'Modele non charge'}), 500
        
        X, donnees_cleaned = preprocesser_donnees(test_data)
        prediction_proba = model.predict_proba(X)
        probabilite_defaut = float(prediction_proba[0][1])
        score_risque = calculer_score_risque(probabilite_defaut)
        recommandation = generer_recommandation(score_risque, probabilite_defaut, donnees_cleaned)
        
        return jsonify({
            'testData': test_data,
            'scoreRisque': score_risque,
            'probabiliteDefaut': round(probabilite_defaut, 4),
            'recommandation': recommandation,
            'classeRisque': "RISQUE_ELEVE" if probabilite_defaut >= 0.5 else "RISQUE_FAIBLE"
        }), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500


if __name__ == '__main__':
    print("\n" + "="*60)
    print("API IA - Prediction de Risque de Pret Bancaire")
    print("="*60)
    print(f"Modele: Regression Logistique (95.92% precision)")
    print(f"Python: 3.14 (scikit-learn)")
    print(f"URL: http://localhost:5000")
    print(f"Endpoints disponibles:")
    print(f"   - POST /predict         : Prediction de risque")
    print(f"   - GET  /health          : Verification du service")
    print(f"   - GET  /model-info      : Informations sur le modele")
    print(f"   - GET  /test-predict    : Test avec donnees exemple")
    print("="*60 + "\n")
    
    # Lancement du serveur Flask
    app.run(host='0.0.0.0', port=5000, debug=True)
