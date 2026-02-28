<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <fmt:setLocale value="fr_FR" />
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Paramètres - NeuroBank Admin</title>

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

                    *,
                    *::before,
                    *::after {
                        box-sizing: border-box;
                        margin: 0;
                        padding: 0;
                    }

                    body {
                        font-family: 'Inter', -apple-system, sans-serif;
                        background: var(--bg-dark);
                        color: var(--text-white);
                        line-height: 1.6;
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

                    .dashboard-container {
                        display: flex;
                        min-height: 100vh;
                        position: relative;
                        z-index: 1;
                    }

                    .sidebar {
                        width: 280px;
                        background: rgba(19, 24, 39, 0.7);
                        backdrop-filter: blur(20px);
                        border-right: 1px solid var(--border-dark);
                        padding: 2rem 1.5rem;
                        position: fixed;
                        height: 100vh;
                        overflow-y: auto;
                    }

                    .logo {
                        display: flex;
                        align-items: center;
                        gap: 0.75rem;
                        margin-bottom: 2rem;
                        padding-bottom: 1.5rem;
                        border-bottom: 1px solid var(--border-dark);
                    }

                    .logo-icon {
                        width: 45px;
                        height: 45px;
                        background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
                        border-radius: 0.75rem;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 1.35rem;
                        color: white;
                    }

                    .logo-text {
                        font-size: 1.35rem;
                        font-weight: 800;
                        background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                    }

                    .nav-links {
                        display: flex;
                        flex-direction: column;
                        gap: 0.5rem;
                    }

                    .nav-item {
                        display: flex;
                        align-items: center;
                        gap: 0.875rem;
                        padding: 1rem 1.25rem;
                        color: var(--text-gray);
                        text-decoration: none;
                        border-radius: 0.75rem;
                        transition: all 0.3s ease;
                        font-weight: 500;
                    }

                    .nav-item:hover,
                    .nav-item.active {
                        background: rgba(59, 130, 246, 0.1);
                        color: var(--accent-blue);
                    }

                    .nav-item.active {
                        border-left: 3px solid var(--accent-blue);
                    }

                    .nav-item.logout {
                        margin-top: 2rem;
                        color: var(--error);
                        border-top: 1px solid var(--border-dark);
                        padding-top: 1.5rem;
                    }

                    .main-content {
                        margin-left: 280px;
                        flex: 1;
                        padding: 2rem;
                    }

                    .page-header {
                        margin-bottom: 2.5rem;
                    }

                    .page-title {
                        font-size: 2rem;
                        font-weight: 800;
                        margin-bottom: 0.5rem;
                    }

                    .alert {
                        padding: 1.25rem 1.5rem;
                        border-radius: 0.75rem;
                        margin-bottom: 2rem;
                        display: flex;
                        align-items: center;
                        gap: 1rem;
                        animation: slideIn 0.3s ease;
                    }

                    @keyframes slideIn {
                        from {
                            opacity: 0;
                            transform: translateY(-10px);
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
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

                    .settings-grid {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 2rem;
                        margin-bottom: 2rem;
                    }

                    .settings-card {
                        background: rgba(19, 24, 39, 0.5);
                        backdrop-filter: blur(10px);
                        border: 1px solid var(--border-dark);
                        border-radius: 1.25rem;
                        padding: 2rem;
                        transition: transform 0.3s ease;
                    }

                    .settings-card:hover {
                        transform: translateY(-5px);
                        border-color: var(--accent-blue);
                    }

                    .settings-card.full-width {
                        grid-column: 1 / -1;
                    }

                    .card-title {
                        font-size: 1.25rem;
                        font-weight: 700;
                        margin-bottom: 1.5rem;
                        display: flex;
                        align-items: center;
                        gap: 0.75rem;
                    }

                    .card-icon {
                        width: 45px;
                        height: 45px;
                        border-radius: 0.75rem;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 1.35rem;
                    }

                    .icon-blue {
                        background: rgba(59, 130, 246, 0.1);
                        color: var(--accent-blue);
                    }

                    .icon-purple {
                        background: rgba(139, 92, 246, 0.1);
                        color: var(--accent-purple);
                    }

                    .icon-green {
                        background: rgba(16, 185, 129, 0.1);
                        color: var(--success);
                    }

                    .form-group {
                        margin-bottom: 1.5rem;
                    }

                    .form-label {
                        display: block;
                        margin-bottom: 0.5rem;
                        font-weight: 600;
                        color: var(--text-gray-light);
                        font-size: 0.9rem;
                    }

                    .form-input {
                        width: 100%;
                        padding: 0.875rem 1.25rem;
                        background: var(--bg-hover);
                        border: 1px solid var(--border-dark);
                        border-radius: 0.75rem;
                        color: var(--text-white);
                        font-family: inherit;
                        font-size: 1rem;
                        transition: all 0.2s;
                    }

                    .form-input:focus {
                        outline: none;
                        border-color: var(--accent-blue);
                        box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
                    }

                    .form-input:disabled {
                        opacity: 0.6;
                        cursor: not-allowed;
                    }

                    .btn {
                        display: inline-flex;
                        align-items: center;
                        gap: 0.75rem;
                        padding: 0.875rem 1.75rem;
                        color: white;
                        background: linear-gradient(135deg, var(--accent-blue), var(--accent-blue-dark));
                        text-decoration: none;
                        border-radius: 0.75rem;
                        font-weight: 600;
                        transition: all 0.3s ease;
                        border: none;
                        cursor: pointer;
                        font-family: inherit;
                        font-size: 1rem;
                    }

                    .btn:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 8px 25px rgba(59, 130, 246, 0.4);
                    }

                    .info-section {
                        background: rgba(255, 255, 255, 0.03);
                        border-radius: 1rem;
                        padding: 1.5rem;
                    }

                    .info-grid {
                        display: grid;
                        grid-template-columns: repeat(3, 1fr);
                        gap: 2rem;
                    }

                    .info-item {
                        display: flex;
                        justify-content: space-between;
                        padding: 1rem 0;
                        border-bottom: 1px solid var(--border-dark);
                    }

                    .info-item:last-child {
                        border-bottom: none;
                    }

                    .info-label {
                        color: var(--text-gray);
                        font-size: 0.9rem;
                    }

                    .info-value {
                        font-weight: 600;
                        color: var(--text-white);
                    }

                    .progress-bar-container {
                        width: 100%;
                        height: 10px;
                        background: rgba(255, 255, 255, 0.1);
                        border-radius: 5px;
                        overflow: hidden;
                        margin-top: 0.75rem;
                    }

                    .progress-bar {
                        height: 100%;
                        background: linear-gradient(90deg, var(--accent-blue), var(--accent-purple));
                        transition: width 0.5s ease;
                        box-shadow: 0 0 10px rgba(59, 130, 246, 0.5);
                    }

                    .status-badge {
                        display: inline-flex;
                        align-items: center;
                        gap: 0.5rem;
                        padding: 0.5rem 1rem;
                        border-radius: 0.5rem;
                        font-size: 0.875rem;
                        font-weight: 600;
                    }

                    .status-online {
                        background: rgba(16, 185, 129, 0.1);
                        color: var(--success);
                    }
                </style>
            </head>

            <body>
                <div class="animated-bg">
                    <div class="gradient-orb orb-1"></div>
                    <div class="gradient-orb orb-2"></div>
                </div>

                <div class="dashboard-container">
                    <aside class="sidebar">
                        <div class="logo">
                            <div class="logo-icon"><i class="fas fa-university"></i></div>
                            <div class="logo-text">NeuroBank</div>
                        </div>

                        <div
                            style="background: rgba(245, 158, 11, 0.1); border: 1px solid rgba(245, 158, 11, 0.3); border-radius: 0.75rem; padding: 0.875rem 1.25rem; margin-bottom: 2rem; display: flex; align-items: center; justify-content: space-between;">
                            <span
                                style="color: var(--text-gray-light); font-size: 0.85rem; font-weight: 500;">Rôle</span>
                            <span
                                style="background: rgba(245, 158, 11, 0.2); color: var(--warning); padding: 0.375rem 0.875rem; border-radius: 0.5rem; font-weight: 700; font-size: 0.875rem;">ADMIN</span>
                        </div>

                        <nav class="nav-links">
                            <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item">
                                <i class="fas fa-chart-pie"></i> Tableau de bord
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/users" class="nav-item">
                                <i class="fas fa-users"></i> Utilisateurs
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/settings" class="nav-item active">
                                <i class="fas fa-cog"></i> Paramètres
                            </a>
                            <a href="${pageContext.request.contextPath}/logout" class="nav-item logout">
                                <i class="fas fa-sign-out-alt"></i> Déconnexion
                            </a>
                        </nav>
                    </aside>

                    <main class="main-content">
                        <div class="page-header">
                            <h1 class="page-title">Paramètres & Configuration</h1>
                            <p style="color: var(--text-gray);">Gérer votre profil et la configuration du système</p>
                        </div>

                        <c:if test="${not empty sessionScope.successMsg}">
                            <div class="alert alert-success">
                                <i class="fas fa-check-circle" style="font-size: 1.5rem;"></i>
                                <span>${sessionScope.successMsg}</span>
                            </div>
                            <c:remove var="successMsg" scope="session" />
                        </c:if>

                        <c:if test="${not empty sessionScope.errorMsg}">
                            <div class="alert alert-error">
                                <i class="fas fa-exclamation-circle" style="font-size: 1.5rem;"></i>
                                <span>${sessionScope.errorMsg}</span>
                            </div>
                            <c:remove var="errorMsg" scope="session" />
                        </c:if>

                        <div class="settings-grid">
                            <!-- Profile Settings -->
                            <div class="settings-card">
                                <h2 class="card-title">
                                    <div class="card-icon icon-blue"><i class="fas fa-user"></i></div>
                                    Profil Administrateur
                                </h2>
                                <form method="post" action="${pageContext.request.contextPath}/admin/settings">
                                    <input type="hidden" name="action" value="updateProfile">

                                    <div class="form-group">
                                        <label class="form-label">Prénom</label>
                                        <input type="text" name="prenom" class="form-input" value="${admin.prenom}"
                                            required>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label">Nom</label>
                                        <input type="text" name="nom" class="form-input" value="${admin.nom}" required>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label">Email</label>
                                        <input type="email" name="login" class="form-input" value="${admin.login}"
                                            required>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label">Compte créé le</label>
                                        <input type="text" class="form-input"
                                            value="<fmt:formatDate value='${admin.dateCreation}' pattern='dd/MM/yyyy' />"
                                            disabled>
                                    </div>

                                    <button type="submit" class="btn">
                                        <i class="fas fa-save"></i> Enregistrer le profil
                                    </button>
                                </form>
                            </div>

                            <!-- Password Change -->
                            <div class="settings-card">
                                <h2 class="card-title">
                                    <div class="card-icon icon-purple"><i class="fas fa-key"></i></div>
                                    Changer le mot de passe
                                </h2>
                                <form method="post" action="${pageContext.request.contextPath}/admin/settings">
                                    <input type="hidden" name="action" value="changePassword">

                                    <div class="form-group">
                                        <label class="form-label">Mot de passe actuel</label>
                                        <input type="password" name="currentPassword" class="form-input" required>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label">Nouveau mot de passe</label>
                                        <input type="password" name="newPassword" class="form-input" minlength="6"
                                            required>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label">Confirmer le mot de passe</label>
                                        <input type="password" name="confirmPassword" class="form-input" minlength="6"
                                            required>
                                    </div>

                                    <button type="submit" class="btn">
                                        <i class="fas fa-lock"></i> Modifier le mot de passe
                                    </button>
                                </form>
                            </div>

                            <!-- System Information -->
                            <div class="settings-card full-width">
                                <h2 class="card-title">
                                    <div class="card-icon icon-green"><i class="fas fa-server"></i></div>
                                    Informations Système
                                </h2>

                                <div class="info-grid">
                                    <div class="info-section">
                                        <h3
                                            style="font-size: 1rem; color: var(--text-gray); margin-bottom: 1rem; font-weight: 600;">
                                            <i class="fas fa-microchip"></i> Serveur
                                        </h3>
                                        <div class="info-item">
                                            <span class="info-label">Java Version</span>
                                            <span class="info-value">${javaVersion}</span>
                                        </div>
                                        <div class="info-item">
                                            <span class="info-label">Système</span>
                                            <span class="info-value">${osName}</span>
                                        </div>
                                    </div>

                                    <div class="info-section">
                                        <h3
                                            style="font-size: 1rem; color: var(--text-gray); margin-bottom: 1rem; font-weight: 600;">
                                            <i class="fas fa-memory"></i> Mémoire
                                        </h3>
                                        <div class="info-item">
                                            <span class="info-label">Utilisée</span>
                                            <span class="info-value">${usedMemoryMB} MB</span>
                                        </div>
                                        <div class="info-item">
                                            <span class="info-label">Total</span>
                                            <span class="info-value">${totalMemoryMB} MB</span>
                                        </div>
                                        <div class="progress-bar-container">
                                            <div class="progress-bar" style="width: ${memoryUsagePercent}%;"></div>
                                        </div>
                                        <div
                                            style="text-align: center; margin-top: 0.5rem; color: var(--text-gray); font-size: 0.875rem;">
                                            ${memoryUsagePercent}% utilisé
                                        </div>
                                    </div>

                                    <div class="info-section">
                                        <h3
                                            style="font-size: 1rem; color: var(--text-gray); margin-bottom: 1rem; font-weight: 600;">
                                            <i class="fas fa-cogs"></i> Application
                                        </h3>
                                        <div class="info-item">
                                            <span class="info-label">Version</span>
                                            <span class="info-value">1.0.0</span>
                                        </div>
                                        <div class="info-item">
                                            <span class="info-label">Status</span>
                                            <span class="status-badge status-online">
                                                <i class="fas fa-circle" style="font-size: 0.5rem;"></i> En ligne
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>
                </div>
            </body>

            </html>