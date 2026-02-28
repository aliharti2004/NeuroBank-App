"""
Configuration de l'API Flask
"""
import os

class Config:
    """Configuration de base"""
    
    # Flask
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'dev-secret-key-change-in-production'
    DEBUG = True
    
    # Serveur
    HOST = '0.0.0.0'
    PORT = 5000
    
    # Modèle ML
    MODEL_DIR = 'models'
    MODEL_FILE = 'modele_banque.keras'
    SCALER_FILE = 'scaler_banque.joblib'
    
    # Seuils de risque
    SEUIL_RISQUE_FAIBLE = 30      # Score < 30 = risque faible
    SEUIL_RISQUE_MODERE = 50      # Score 30-50 = risque modéré
    SEUIL_RISQUE_ELEVE = 70       # Score 50-70 = risque élevé
                                   # Score > 70 = risque très élevé
    
    SEUIL_PROBABILITE_DEFAUT = 0.5  # Probabilité >= 0.5 = risque élevé
    
    # Encodages
    VILLE_ENCODING = {
        'PARIS': 1,
        'MARSEILLE': 2,
        'LYON': 3,
        'TOULOUSE': 4,
        'NICE': 5,
        'BORDEAUX': 6,
        'INCONNUE': 0
    }
    
    TYPE_PRET_ENCODING = {
        'immobilier': 1,
        'automobile': 2,
        'personnel': 3,
        'etudes': 4
    }
    
    CODE_POSTAL_MAPPING = {
        'PARIS': 75001,
        'MARSEILLE': 13001,
        'LYON': 69001,
        'TOULOUSE': 31000,
        'NICE': 6000,
        'BORDEAUX': 33000,
        'INCONNUE': 0
    }
    
    # CORS
    CORS_ORIGINS = ['http://localhost:8080', 'http://localhost:8081']
    
    # Logging
    LOG_LEVEL = 'INFO'
    LOG_FORMAT = '[%(asctime)s] %(levelname)s in %(module)s: %(message)s'


class ProductionConfig(Config):
    """Configuration pour la production"""
    DEBUG = False
    
    # Charger la clé secrète depuis les variables d'environnement
    SECRET_KEY = os.environ.get('SECRET_KEY')
    if not SECRET_KEY:
        raise ValueError("SECRET_KEY doit être définie en production")


class DevelopmentConfig(Config):
    """Configuration pour le développement"""
    DEBUG = True
    LOG_LEVEL = 'DEBUG'


class TestConfig(Config):
    """Configuration pour les tests"""
    TESTING = True
    DEBUG = True


# Configuration par défaut
config = {
    'development': DevelopmentConfig,
    'production': ProductionConfig,
    'test': TestConfig,
    'default': DevelopmentConfig
}


def get_config(env='default'):
    """Retourne la configuration appropriée"""
    return config.get(env, config['default'])
