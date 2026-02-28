"""
Script pour sauvegarder le modèle de régression logistique
et le scaler en fichiers .joblib pour l'API Flask
"""
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler, LabelEncoder
from sklearn.linear_model import LogisticRegression
import joblib

# 1. CHARGEMENT DES DONNÉES
print("Chargement des donnees...")
# REMPLACEZ PAR LE CHEMIN DE VOTRE FICHIER CSV
df = pd.read_csv('votre_dataset.csv')  # <-- MODIFIEZ CE CHEMIN

print(f"Dataset charge: {df.shape[0]} lignes, {df.shape[1]} colonnes")
print(f"Colonnes: {list(df.columns)}")

# 2. PRÉPARATION DES DONNÉES
print("\nPreparation des donnees...")

# Encodage des variables catégorielles
le_ville = LabelEncoder()
le_type = LabelEncoder()

if 'ville' in df.columns:
    df['ville_encoded'] = le_ville.fit_transform(df['ville'])
if 'type' in df.columns:
    df['type_encoded'] = le_type.fit_transform(df['type'])

# Définition des features (colonnes utilisées pour la prédiction)
# AJUSTEZ SELON VOS COLONNES
feature_columns = ['revenu', 'remboursement', 'duree', 'taux', 'CP', 'ville_encoded', 'type_encoded']

# Vérifier que les colonnes existent
available_features = [col for col in feature_columns if col in df.columns]
print(f"Features utilisees: {available_features}")

X = df[available_features]
y = df['cible']  # <-- MODIFIEZ LE NOM DE LA COLONNE CIBLE SI NÉCESSAIRE

print(f"X shape: {X.shape}")
print(f"y shape: {y.shape}")

# 3. SPLIT TRAIN/TEST
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42, stratify=y
)

print(f"\nTrain set: {X_train.shape[0]} exemples")
print(f"Test set: {X_test.shape[0]} exemples")

# 4. NORMALISATION
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

# 5. ENTRAÎNEMENT DU MODÈLE
print("\nEntrainement du modele de regression logistique...")
model = LogisticRegression(
    max_iter=1000,
    random_state=42,
    class_weight='balanced'  # Pour gérer les classes déséquilibrées
)

model.fit(X_train_scaled, y_train)

# 6. ÉVALUATION
train_score = model.score(X_train_scaled, y_train)
test_score = model.score(X_test_scaled, y_test)

print(f"\nPrecision train: {train_score:.4f} ({train_score*100:.2f}%)")
print(f"Precision test: {test_score:.4f} ({test_score*100:.2f}%)")

# 7. SAUVEGARDE DES FICHIERS
output_dir = 'C:/Users/dell/OneDrive/Documents/Bank_prets/BankLoanProject/flask_api/models/'

print(f"\nSauvegarde des fichiers dans {output_dir}...")

# Sauvegarder le modèle
joblib.dump(model, output_dir + 'modele_regression_logistique.joblib')
print("✓ Modele sauvegarde: modele_regression_logistique.joblib")

# Sauvegarder le scaler
joblib.dump(scaler, output_dir + 'scaler_banque.joblib')
print("✓ Scaler sauvegarde: scaler_banque.joblib")

# Sauvegarder les encodeurs (optionnel mais utile)
joblib.dump(le_ville, output_dir + 'label_encoder_ville.joblib')
joblib.dump(le_type, output_dir + 'label_encoder_type.joblib')
print("✓ Encodeurs sauvegardes")

# Sauvegarder les noms des features (important!)
joblib.dump(available_features, output_dir + 'feature_names.joblib')
print("✓ Noms des features sauvegardes")

print("\n" + "="*50)
print("SAUVEGARDE TERMINEE AVEC SUCCES!")
print("="*50)
print(f"\nFichiers generes:")
print(f"  - modele_regression_logistique.joblib")
print(f"  - scaler_banque.joblib")
print(f"  - label_encoder_ville.joblib")
print(f"  - label_encoder_type.joblib")
print(f"  - feature_names.joblib")
print(f"\nVous pouvez maintenant utiliser ces fichiers dans l'API Flask!")
