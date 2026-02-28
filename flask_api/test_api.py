"""
Script de test pour l'API Flask de prédiction de risque de prêt
Teste tous les endpoints et affiche les résultats
"""

import requests
import json
from datetime import datetime

# Configuration
BASE_URL = "http://localhost:5000"

def print_section(title):
    """Affiche un titre de section"""
    print("\n" + "="*60)
    print(f"  {title}")
    print("="*60)

def test_health():
    """Test de l'endpoint /health"""
    print_section("TEST 1: Vérification de santé (/health)")
    try:
        response = requests.get(f"{BASE_URL}/health")
        print(f"Status Code: {response.status_code}")
        print(f"Réponse: {json.dumps(response.json(), indent=2, ensure_ascii=False)}")
        return response.status_code == 200
    except Exception as e:
        print(f"❌ ERREUR: {str(e)}")
        return False

def test_model_info():
    """Test de l'endpoint /model-info"""
    print_section("TEST 2: Informations du modèle (/model-info)")
    try:
        response = requests.get(f"{BASE_URL}/model-info")
        print(f"Status Code: {response.status_code}")
        print(f"Réponse: {json.dumps(response.json(), indent=2, ensure_ascii=False)}")
        return response.status_code == 200
    except Exception as e:
        print(f"❌ ERREUR: {str(e)}")
        return False

def test_predict_risque_faible():
    """Test de prédiction avec un profil à risque faible"""
    print_section("TEST 3: Prédiction - Profil à RISQUE FAIBLE")
    
    # Profil avec bon revenu, mensualité raisonnable
    data = {
        "revenu": 5000,
        "mensualite": 800,
        "duree": 240,
        "taux": 1.2,
        "ville": "PARIS",
        "type_pret": "immobilier"
    }
    
    print(f"Données envoyées: {json.dumps(data, indent=2, ensure_ascii=False)}")
    
    try:
        response = requests.post(
            f"{BASE_URL}/predict",
            json=data,
            headers={"Content-Type": "application/json"}
        )
        print(f"\nStatus Code: {response.status_code}")
        result = response.json()
        print(f"Réponse: {json.dumps(result, indent=2, ensure_ascii=False)}")
        
        # Vérification
        if response.status_code == 200:
            print(f"\n✅ Score de risque: {result['scoreRisque']}/100")
            print(f"✅ Classe: {result['classeRisque']}")
        
        return response.status_code == 200
    except Exception as e:
        print(f"❌ ERREUR: {str(e)}")
        return False

def test_predict_risque_eleve():
    """Test de prédiction avec un profil à risque élevé"""
    print_section("TEST 4: Prédiction - Profil à RISQUE ELEVÉ")
    
    # Profil avec faible revenu, mensualité élevée
    data = {
        "revenu": 1500,
        "mensualite": 1200,
        "duree": 360,
        "taux": 3.5,
        "ville": "MARSEILLE",
        "type_pret": "automobile"
    }
    
    print(f"Données envoyées: {json.dumps(data, indent=2, ensure_ascii=False)}")
    
    try:
        response = requests.post(
            f"{BASE_URL}/predict",
            json=data,
            headers={"Content-Type": "application/json"}
        )
        print(f"\nStatus Code: {response.status_code}")
        result = response.json()
        print(f"Réponse: {json.dumps(result, indent=2, ensure_ascii=False)}")
        
        # Vérification
        if response.status_code == 200:
            print(f"\n⚠️ Score de risque: {result['scoreRisque']}/100")
            print(f"⚠️ Classe: {result['classeRisque']}")
        
        return response.status_code == 200
    except Exception as e:
        print(f"❌ ERREUR: {str(e)}")
        return False

def test_predict_cas_moyen():
    """Test de prédiction avec un cas moyen"""
    print_section("TEST 5: Prédiction - Profil MOYEN")
    
    data = {
        "revenu": 3000,
        "mensualite": 900,
        "duree": 180,
        "taux": 2.0,
        "ville": "LYON",
        "type_pret": "immobilier"
    }
    
    print(f"Données envoyées: {json.dumps(data, indent=2, ensure_ascii=False)}")
    
    try:
        response = requests.post(
            f"{BASE_URL}/predict",
            json=data,
            headers={"Content-Type": "application/json"}
        )
        print(f"\nStatus Code: {response.status_code}")
        result = response.json()
        print(f"Réponse: {json.dumps(result, indent=2, ensure_ascii=False)}")
        
        return response.status_code == 200
    except Exception as e:
        print(f"❌ ERREUR: {str(e)}")
        return False

def test_predict_test_endpoint():
    """Test de l'endpoint /test-predict"""
    print_section("TEST 6: Endpoint de test (/test-predict)")
    try:
        response = requests.get(f"{BASE_URL}/test-predict")
        print(f"Status Code: {response.status_code}")
        print(f"Réponse: {json.dumps(response.json(), indent=2, ensure_ascii=False)}")
        return response.status_code == 200
    except Exception as e:
        print(f"❌ ERREUR: {str(e)}")
        return False

def main():
    """Fonction principale - exécute tous les tests"""
    print("\n" + "🏦"*30)
    print("  TESTS DE L'API FLASK - PRÉDICTION DE RISQUE DE PRÊT")
    print("🏦"*30)
    print(f"\nDate: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"URL de l'API: {BASE_URL}")
    
    # Vérifier que l'API est accessible
    try:
        requests.get(BASE_URL, timeout=2)
    except:
        print("\n❌ ERREUR: L'API n'est pas accessible!")
        print("Veuillez démarrer l'API avec: python app.py")
        return
    
    # Exécuter tous les tests
    tests = [
        ("Health Check", test_health),
        ("Model Info", test_model_info),
        ("Prédiction - Risque Faible", test_predict_risque_faible),
        ("Prédiction - Risque Élevé", test_predict_risque_eleve),
        ("Prédiction - Cas Moyen", test_predict_cas_moyen),
        ("Test Endpoint", test_predict_test_endpoint)
    ]
    
    results = []
    for test_name, test_func in tests:
        result = test_func()
        results.append((test_name, result))
    
    # Résumé des résultats
    print_section("RÉSUMÉ DES TESTS")
    passed = sum(1 for _, result in results if result)
    total = len(results)
    
    for test_name, result in results:
        status = "✅ RÉUSSI" if result else "❌ ÉCHOUÉ"
        print(f"{status} - {test_name}")
    
    print(f"\nRésultat global: {passed}/{total} tests réussis")
    
    if passed == total:
        print("\n🎉 Tous les tests sont passés avec succès!")
    else:
        print(f"\n⚠️ {total - passed} test(s) ont échoué")

if __name__ == "__main__":
    main()
