<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Compléter votre profil - NeuroBank</title>

            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
                rel="stylesheet">

            <style>
                :root {
                    --bg-dark: #0a0e1a;
                    --bg-card: #131827;
                    --bg-hover: #1a2234;
                    --text-white: #ffffff;
                    --text-gray: #94a3b8;
                    --text-gray-light: #cbd5e1;
                    --accent-blue: #3b82f6;
                    --accent-blue-dark: #2563eb;
                    --accent-purple: #8b5cf6;
                    --success: #10b981;
                    --warning: #f59e0b;
                    --error: #ef4444;
                    --border-dark: #1e293b;
                }

                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Inter', sans-serif;
                    background: var(--bg-dark);
                    color: var(--text-white);
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    position: relative;
                    overflow-x: hidden;
                }

                .animated-bg {
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    pointer-events: none;
                    z-index: 0;
                }

                .gradient-orb {
                    position: absolute;
                    border-radius: 50%;
                    filter: blur(80px);
                    opacity: 0.15;
                    animation: float 20s infinite ease-in-out;
                }

                .orb-1 {
                    width: 500px;
                    height: 500px;
                    background: var(--accent-blue);
                    top: -100px;
                    right: -100px;
                }

                .orb-2 {
                    width: 400px;
                    height: 400px;
                    background: var(--accent-purple);
                    bottom: -100px;
                    left: -100px;
                    animation-delay: -10s;
                }

                @keyframes float {

                    0%,
                    100% {
                        transform: translate(0, 0) scale(1);
                    }

                    33% {
                        transform: translate(30px, -30px) scale(1.1);
                    }

                    66% {
                        transform: translate(-20px, 20px) scale(0.9);
                    }
                }

                .container {
                    position: relative;
                    z-index: 1;
                    width: 100%;
                    max-width: 600px;
                    padding: 2rem;
                }

                .card {
                    background: rgba(19, 24, 39, 0.7);
                    backdrop-filter: blur(20px);
                    border: 1px solid var(--border-dark);
                    border-radius: 1.5rem;
                    padding: 3rem;
                    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                }

                .header {
                    text-align: center;
                    margin-bottom: 2.5rem;
                }

                .logo-icon {
                    width: 70px;
                    height: 70px;
                    margin: 0 auto 1.5rem;
                    background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
                    border-radius: 1.25rem;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 2rem;
                }

                h1 {
                    font-size: 2rem;
                    font-weight: 800;
                    margin-bottom: 0.5rem;
                    background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                    background-clip: text;
                }

                .subtitle {
                    color: var(--text-gray);
                    font-size: 1rem;
                    line-height: 1.6;
                }

                .alert {
                    padding: 1rem 1.25rem;
                    border-radius: 0.75rem;
                    margin-bottom: 1.5rem;
                    display: flex;
                    align-items: center;
                    gap: 0.75rem;
                    font-size: 0.95rem;
                }

                .alert-success {
                    background: rgba(16, 185, 129, 0.1);
                    border: 1px solid rgba(16, 185, 129, 0.3);
                    color: var(--success);
                }

                .alert-error {
                    background: rgba(239, 68, 68, 0.1);
                    border: 1px solid rgba(239, 68, 68, 0.3);
                    color: var(--error);
                }

                .info-box {
                    background: rgba(59, 130, 246, 0.1);
                    border: 1px solid rgba(59, 130, 246, 0.3);
                    border-radius: 0.75rem;
                    padding: 1.25rem;
                    margin-bottom: 2rem;
                }

                .info-box h3 {
                    color: var(--accent-blue);
                    font-size: 1rem;
                    margin-bottom: 0.75rem;
                    display: flex;
                    align-items: center;
                    gap: 0.5rem;
                }

                .info-box p {
                    color: var(--text-gray-light);
                    font-size: 0.9rem;
                    line-height: 1.6;
                }

                .form-group {
                    margin-bottom: 1.5rem;
                }

                label {
                    display: block;
                    margin-bottom: 0.5rem;
                    font-weight: 600;
                    color: var(--text-gray-light);
                    font-size: 0.95rem;
                }

                .required {
                    color: var(--error);
                }

                input {
                    width: 100%;
                    padding: 1rem 1.25rem;
                    background: var(--bg-hover);
                    border: 1px solid var(--border-dark);
                    border-radius: 0.75rem;
                    color: var(--text-white);
                    font-family: inherit;
                    font-size: 1rem;
                    transition: all 0.3s ease;
                }

                input:focus {
                    outline: none;
                    border-color: var(--accent-blue);
                    box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
                }

                .input-icon {
                    position: relative;
                }

                .input-icon i {
                    position: absolute;
                    left: 1.25rem;
                    top: 50%;
                    transform: translateY(-50%);
                    color: var(--text-gray);
                }

                .input-icon input {
                    padding-left: 3rem;
                }

                .btn {
                    width: 100%;
                    padding: 1.125rem 2rem;
                    background: linear-gradient(135deg, var(--accent-blue), var(--accent-blue-dark));
                    color: white;
                    border: none;
                    border-radius: 0.75rem;
                    font-size: 1.05rem;
                    font-weight: 700;
                    cursor: pointer;
                    transition: all 0.3s ease;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    gap: 0.75rem;
                    margin-top: 2rem;
                }

                .btn:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 10px 30px rgba(59, 130, 246, 0.4);
                }

                .help-text {
                    font-size: 0.85rem;
                    color: var(--text-gray);
                    margin-top: 0.5rem;
                }
            </style>
        </head>

        <body>
            <div class="animated-bg">
                <div class="gradient-orb orb-1"></div>
                <div class="gradient-orb orb-2"></div>
            </div>

            <div class="container">
                <div class="card">
                    <div class="header">
                        <div class="logo-icon">
                            <i class="fas fa-user-check"></i>
                        </div>
                        <h1>Complétez votre profil</h1>
                        <p class="subtitle">
                            Avant de faire votre première demande de prêt, veuillez compléter vos informations
                            financières.
                        </p>
                    </div>

                    <c:if test="${not empty sessionScope.successMsg}">
                        <div class="alert alert-success">
                            <i class="fas fa-check-circle"></i>
                            <span>${sessionScope.successMsg}</span>
                        </div>
                        <c:remove var="successMsg" scope="session" />
                    </c:if>

                    <c:if test="${not empty sessionScope.errorMsg}">
                        <div class="alert alert-error">
                            <i class="fas fa-exclamation-circle"></i>
                            <span>${sessionScope.errorMsg}</span>
                        </div>
                        <c:remove var="errorMsg" scope="session" />
                    </c:if>

                    <div class="info-box">
                        <h3><i class="fas fa-info-circle"></i> Pourquoi ces informations ?</h3>
                        <p>
                            Ces informations nous permettent d'évaluer votre capacité de remboursement et de vous
                            proposer
                            des offres de prêt adaptées à votre situation financière. Vos données sont sécurisées et
                            confidentielles.
                        </p>
                    </div>

                    <form method="post" action="${pageContext.request.contextPath}/client/complete-profile">
                        <div class="form-group">
                            <label>Ville <span class="required">*</span></label>
                            <div class="input-icon">
                                <i class="fas fa-city"></i>
                                <input type="text" name="ville" placeholder="Ex: Paris, Lyon, Marseille..." required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Code Postal <span class="required">*</span></label>
                            <div class="input-icon">
                                <i class="fas fa-map-marker-alt"></i>
                                <input type="text" name="codePostal" placeholder="Ex: 75001" pattern="[0-9]{5}"
                                    maxlength="5" required>
                            </div>
                            <p class="help-text">Format: 5 chiffres</p>
                        </div>

                        <div class="form-group">
                            <label>Revenu Mensuel (€) <span class="required">*</span></label>
                            <div class="input-icon">
                                <i class="fas fa-euro-sign"></i>
                                <input type="number" name="revenu" placeholder="Ex: 2500" step="0.01" min="0" required>
                            </div>
                            <p class="help-text">Votre revenu mensuel net</p>
                        </div>

                        <button type="submit" class="btn">
                            <i class="fas fa-check"></i>
                            Valider et continuer
                        </button>
                    </form>
                </div>
            </div>
        </body>

        </html>