<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <fmt:setLocale value="fr_FR" />
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Détail Demande #${demande.idDemande} - NeuroBank Agent</title>

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

                    html {
                        scroll-behavior: smooth;
                    }

                    body {
                        font-family: 'Inter', sans-serif;
                        background: var(--bg-dark);
                        color: var(--text-white);
                        line-height: 1.6;
                        overflow-x: hidden;
                    }

                    /* Animated Background */
                    .animated-bg {
                        position: fixed;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 100%;
                        z-index: 0;
                        overflow: hidden;
                        pointer-events: none;
                    }

                    .gradient-orb {
                        position: absolute;
                        border-radius: 50%;
                        filter: blur(80px);
                        opacity: 0.2;
                        animation: float 20s ease-in-out infinite;
                    }

                    .orb-1 {
                        width: 500px;
                        height: 500px;
                        background: var(--accent-blue);
                        top: -100px;
                        right: -100px;
                        animation-delay: 0s;
                    }

                    .orb-2 {
                        width: 400px;
                        height: 400px;
                        background: var(--accent-purple);
                        bottom: -150px;
                        left: 10%;
                        animation-delay: 7s;
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

                    @keyframes fadeInUp {
                        from {
                            opacity: 0;
                            transform: translateY(30px);
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }

                    .dashboard-container {
                        display: flex;
                        min-height: 100vh;
                        position: relative;
                        z-index: 1;
                    }

                    /* Sidebar with glassmorphism */
                    .sidebar {
                        width: 280px;
                        background: rgba(19, 24, 39, 0.7);
                        backdrop-filter: blur(20px);
                        border-right: 1px solid var(--border-dark);
                        padding: 2rem 1.5rem;
                        position: fixed;
                        height: 100vh;
                        overflow-y: auto;
                        z-index: 100;
                    }

                    .logo {
                        display: flex;
                        align-items: center;
                        gap: 0.75rem;
                        margin-bottom: 3rem;
                        padding-bottom: 1.5rem;
                        border-bottom: 1px solid var(--border-dark);
                        transition: transform 0.3s ease;
                        cursor: pointer;
                    }

                    .logo:hover {
                        transform: scale(1.05);
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
                        animation: pulse-icon 3s ease-in-out infinite;
                    }

                    @keyframes pulse-icon {

                        0%,
                        100% {
                            transform: scale(1);
                            box-shadow: 0 0 0 0 rgba(59, 130, 246, 0.4);
                        }

                        50% {
                            transform: scale(1.05);
                            box-shadow: 0 0 20px 5px rgba(59, 130, 246, 0.2);
                        }
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
                        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                        font-weight: 500;
                    }

                    .nav-item i {
                        font-size: 1.125rem;
                        transition: transform 0.3s ease;
                    }

                    .nav-item:hover {
                        background: var(--bg-hover);
                        color: var(--text-white);
                        transform: translateX(5px);
                    }

                    .nav-item:hover i {
                        transform: scale(1.1);
                    }

                    .nav-item.active {
                        background: linear-gradient(135deg, rgba(59, 130, 246, 0.15), rgba(139, 92, 246, 0.15));
                        color: var(--accent-blue);
                        border-left: 3px solid var(--accent-blue);
                    }

                    .nav-item.logout {
                        margin-top: 2rem;
                        color: var(--error);
                        border-top: 1px solid var(--border-dark);
                        padding-top: 1.5rem;
                    }

                    .nav-item.logout:hover {
                        background: rgba(239, 68, 68, 0.1);
                    }

                    /* Main Content */
                    .main-content {
                        margin-left: 280px;
                        flex: 1;
                        padding: 2rem;
                    }

                    .page-header {
                        margin-bottom: 2rem;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        padding-bottom: 1.5rem;
                        border-bottom: 1px solid var(--border-dark);
                        animation: fadeInUp 0.5s ease;
                    }

                    .page-title {
                        font-size: 2rem;
                        font-weight: 900;
                        background: linear-gradient(135deg, var(--text-white), var(--accent-blue));
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                        letter-spacing: -0.02em;
                    }

                    .back-btn {
                        padding: 0.875rem 1.75rem;
                        background: rgba(19, 24, 39, 0.6);
                        backdrop-filter: blur(10px);
                        color: var(--text-gray);
                        text-decoration: none;
                        border-radius: 0.75rem;
                        border: 1px solid var(--border-dark);
                        display: inline-flex;
                        align-items: center;
                        gap: 0.625rem;
                        font-weight: 600;
                        transition: all 0.3s ease;
                    }

                    .back-btn:hover {
                        color: var(--text-white);
                        border-color: var(--accent-blue);
                        transform: translateY(-2px);
                        box-shadow: 0 8px 20px rgba(59, 130, 246, 0.2);
                    }

                    /* Grid Layout */
                    .detail-grid {
                        display: grid;
                        grid-template-columns: 2fr 1fr;
                        gap: 1.5rem;
                        margin-bottom: 2rem;
                    }

                    /* Enhanced Card with 3D effects */
                    .card {
                        background: rgba(19, 24, 39, 0.5);
                        backdrop-filter: blur(10px);
                        border: 1px solid var(--border-dark);
                        border-radius: 1.25rem;
                        padding: 2rem;
                        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                        animation: fadeInUp 0.6s ease;
                        animation-fill-mode: both;
                    }

                    .card:hover {
                        transform: translateY(-5px);
                        border-color: var(--accent-blue);
                        box-shadow: 0 15px 35px rgba(59, 130, 246, 0.2);
                    }

                    .card-header {
                        display: flex;
                        align-items: center;
                        gap: 0.75rem;
                        margin-bottom: 1.75rem;
                        padding-bottom: 1.25rem;
                        border-bottom: 1px solid var(--border-dark);
                    }

                    .card-header i {
                        color: var(--accent-blue);
                        font-size: 1.35rem;
                    }

                    .card-title {
                        font-size: 1.35rem;
                        font-weight: 700;
                    }

                    /* Info Grid */
                    .info-grid {
                        display: grid;
                        grid-template-columns: repeat(2, 1fr);
                        gap: 1.75rem;
                    }

                    .info-item {
                        display: flex;
                        flex-direction: column;
                        gap: 0.625rem;
                    }

                    .info-label {
                        font-size: 0.85rem;
                        color: var(--text-gray);
                        font-weight: 700;
                        text-transform: uppercase;
                        letter-spacing: 0.05em;
                    }

                    .info-value {
                        font-size: 1.125rem;
                        font-weight: 600;
                        color: var(--text-white);
                    }

                    .info-value.highlight {
                        color: var(--accent-blue);
                        font-size: 1.5rem;
                        font-weight: 800;
                    }

                    /* Enhanced Badges */
                    .badge {
                        padding: 0.625rem 1.25rem;
                        border-radius: 0.625rem;
                        font-size: 0.875rem;
                        font-weight: 700;
                        display: inline-flex;
                        align-items: center;
                        gap: 0.5rem;
                        text-transform: uppercase;
                        letter-spacing: 0.05em;
                        transition: all 0.3s ease;
                    }

                    .badge:hover {
                        transform: scale(1.05);
                    }

                    .badge-pending {
                        background: rgba(251, 191, 36, 0.15);
                        color: var(--warning);
                        border: 1px solid rgba(251, 191, 36, 0.4);
                    }

                    .badge-approved {
                        background: rgba(16, 185, 129, 0.15);
                        color: var(--success);
                        border: 1px solid rgba(16, 185, 129, 0.4);
                    }

                    .badge-rejected {
                        background: rgba(239, 68, 68, 0.15);
                        color: var(--error);
                        border: 1px solid rgba(239, 68, 68, 0.4);
                    }

                    /* AI Analysis with glow effect */
                    .ai-score {
                        text-align: center;
                        padding: 2.5rem;
                        background: linear-gradient(135deg, rgba(59, 130, 246, 0.1), rgba(139, 92, 246, 0.1));
                        border-radius: 1.25rem;
                        margin: 1.5rem 0;
                        position: relative;
                        overflow: hidden;
                    }

                    .ai-score::before {
                        content: '';
                        position: absolute;
                        inset: 0;
                        background: radial-gradient(circle at 50% 50%, rgba(59, 130, 246, 0.2), transparent 70%);
                        animation: pulse-glow 3s ease-in-out infinite;
                    }

                    @keyframes pulse-glow {

                        0%,
                        100% {
                            opacity: 0.5;
                        }

                        50% {
                            opacity: 1;
                        }
                    }

                    .ai-score-value {
                        font-size: 3.5rem;
                        font-weight: 900;
                        background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                        margin-bottom: 0.75rem;
                        position: relative;
                        z-index: 1;
                    }

                    .ai-score-label {
                        color: var(--text-gray-light);
                        font-size: 0.95rem;
                        text-transform: uppercase;
                        letter-spacing: 0.1em;
                        font-weight: 700;
                        position: relative;
                        z-index: 1;
                    }

                    /* Progress Bar */
                    .progress-bar {
                        width: 100%;
                        height: 12px;
                        background: var(--bg-dark);
                        border-radius: 10px;
                        overflow: hidden;
                        margin-top: 1.25rem;
                        position: relative;
                        z-index: 1;
                    }

                    .progress-fill {
                        height: 100%;
                        background: linear-gradient(90deg, var(--accent-blue), var(--accent-purple));
                        border-radius: 10px;
                        transition: width 0.8s cubic-bezier(0.4, 0, 0.2, 1);
                        box-shadow: 0 0 15px rgba(59, 130, 246, 0.5);
                    }

                    /* Enhanced Action Buttons with ripple */
                    .action-buttons {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 1.25rem;
                        margin-top: 2rem;
                    }

                    .btn {
                        padding: 1.125rem 2rem;
                        border-radius: 0.875rem;
                        text-decoration: none;
                        font-weight: 700;
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        gap: 0.75rem;
                        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                        border: none;
                        cursor: pointer;
                        font-family: inherit;
                        font-size: 1rem;
                        position: relative;
                        overflow: hidden;
                    }

                    .btn::before {
                        content: '';
                        position: absolute;
                        top: 50%;
                        left: 50%;
                        width: 0;
                        height: 0;
                        border-radius: 50%;
                        background: rgba(255, 255, 255, 0.3);
                        transform: translate(-50%, -50%);
                        transition: width 0.6s, height 0.6s;
                    }

                    .btn:hover::before {
                        width: 400px;
                        height: 400px;
                    }

                    .btn-approve {
                        background: linear-gradient(135deg, var(--success), #059669);
                        color: white;
                        box-shadow: 0 4px 15px rgba(16, 185, 129, 0.4);
                    }

                    .btn-approve:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 12px 30px rgba(16, 185, 129, 0.5);
                    }

                    .btn-reject {
                        background: linear-gradient(135deg, var(--error), #dc2626);
                        color: white;
                        box-shadow: 0 4px 15px rgba(239, 68, 68, 0.4);
                    }

                    .btn-reject:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 12px 30px rgba(239, 68, 68, 0.5);
                    }

                    .btn:disabled {
                        opacity: 0.5;
                        cursor: not-allowed;
                        transform: none !important;
                    }

                    /* Alert */
                    .alert {
                        padding: 1.25rem 1.75rem;
                        border-radius: 0.875rem;
                        margin-bottom: 1.5rem;
                        display: flex;
                        align-items: center;
                        gap: 1rem;
                        animation: fadeInUp 0.5s ease;
                    }

                    .alert-info {
                        background: rgba(59, 130, 246, 0.1);
                        color: var(--accent-blue);
                        border: 1px solid rgba(59, 130, 246, 0.3);
                    }

                    /* Decision Box */
                    .decision-box {
                        margin-top: 2rem;
                        padding: 1.5rem;
                        background: linear-gradient(135deg, rgba(59, 130, 246, 0.05), rgba(139, 92, 246, 0.05));
                        border-radius: 0.75rem;
                        border: 1px solid var(--border-dark);
                    }

                    .decision-box .decision-header {
                        display: flex;
                        align-items: center;
                        gap: 1rem;
                        margin-bottom: 0.5rem;
                    }

                    .decision-box .decision-label {
                        font-size: 0.85rem;
                        color: var(--text-gray);
                        font-weight: 700;
                        text-transform: uppercase;
                        letter-spacing: 0.05em;
                    }

                    .decision-box .decision-value {
                        font-size: 1.125rem;
                        font-weight: 700;
                        display: flex;
                        align-items: center;
                        gap: 0.5rem;
                    }

                    /* Responsive */
                    @media (max-width: 768px) {
                        .sidebar {
                            width: 100%;
                            height: auto;
                            position: relative;
                        }

                        .main-content {
                            margin-left: 0;
                        }

                        .detail-grid {
                            grid-template-columns: 1fr;
                        }

                        .info-grid {
                            grid-template-columns: 1fr;
                        }

                        .action-buttons {
                            grid-template-columns: 1fr;
                        }

                        .page-header {
                            flex-direction: column;
                            align-items: flex-start;
                            gap: 1rem;
                        }
                    }
                </style>
            </head>

            <body>
                <!-- Animated Background -->
                <div class="animated-bg">
                    <div class="gradient-orb orb-1"></div>
                    <div class="gradient-orb orb-2"></div>
                </div>

                <div class="dashboard-container">
                    <!-- Sidebar -->
                    <aside class="sidebar">
                        <div class="logo">
                            <div class="logo-icon">
                                <i class="fas fa-brain"></i>
                            </div>
                            <div class="logo-text">NeuroBank</div>
                        </div>

                        <nav class="nav-links">
                            <a href="${pageContext.request.contextPath}/agent/dashboard" class="nav-item">
                                <i class="fas fa-chart-line"></i>
                                Tableau de bord
                            </a>
                            <a href="${pageContext.request.contextPath}/agent/demandes" class="nav-item active">
                                <i class="fas fa-list"></i>
                                Toutes les demandes
                            </a>
                            <a href="${pageContext.request.contextPath}/agent/historique" class="nav-item">
                                <i class="fas fa-history"></i>
                                Historique
                            </a>
                            <a href="${pageContext.request.contextPath}/logout" class="nav-item logout">
                                <i class="fas fa-sign-out-alt"></i>
                                Déconnexion
                            </a>
                        </nav>
                    </aside>

                    <!-- Main Content -->
                    <main class="main-content">
                        <div class="page-header">
                            <h1 class="page-title">Demande de prêt #${demande.idDemande}</h1>
                            <a href="${pageContext.request.contextPath}/agent/demandes" class="back-btn">
                                <i class="fas fa-arrow-left"></i> Retour
                            </a>
                        </div>

                        <!-- Alert if already processed -->
                        <c:if test="${demande.statut != 'EN_ATTENTE'}">
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle"></i>
                                <span>Cette demande a déjà été traitée.</span>
                            </div>
                        </c:if>

                        <div class="detail-grid">
                            <!-- Left Column - Loan Details -->
                            <div>
                                <!-- Client Info -->
                                <div class="card">
                                    <div class="card-header">
                                        <i class="fas fa-user"></i>
                                        <h2 class="card-title">Informations Client</h2>
                                    </div>
                                    <div class="info-grid">
                                        <c:if test="${not empty clientUser}">
                                            <div class="info-item">
                                                <span class="info-label">Nom</span>
                                                <span class="info-value">${clientUser.nom}</span>
                                            </div>
                                            <div class="info-item">
                                                <span class="info-label">Prénom</span>
                                                <span class="info-value">${clientUser.prenom}</span>
                                            </div>
                                        </c:if>
                                        <div class="info-item">
                                            <span class="info-label">Client ID</span>
                                            <span class="info-value">#${demande.idClient}</span>
                                        </div>
                                        <div class="info-item">
                                            <span class="info-label">Date de demande</span>
                                            <span class="info-value">
                                                <fmt:formatDate value="${demande.dateCreation}"
                                                    pattern="dd/MM/yyyy HH:mm" />
                                            </span>
                                        </div>
                                        <c:if test="${not empty clientInfo}">
                                            <div class="info-item">
                                                <span class="info-label">Ville</span>
                                                <span class="info-value">${clientInfo.ville}</span>
                                            </div>
                                            <div class="info-item">
                                                <span class="info-label">Revenu mensuel</span>
                                                <span class="info-value highlight">
                                                    <fmt:formatNumber value="${clientInfo.revenuMensuel}" type="number"
                                                        maxFractionDigits="0" />€
                                                </span>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>

                                <!-- Loan Details -->
                                <div class="card" style="margin-top: 1.5rem;">
                                    <div class="card-header">
                                        <i class="fas fa-file-invoice-dollar"></i>
                                        <h2 class="card-title">Détails du Prêt</h2>
                                    </div>
                                    <div class="info-grid">
                                        <div class="info-item">
                                            <span class="info-label">Type de prêt</span>
                                            <span class="info-value">
                                                <c:choose>
                                                    <c:when test="${demande.typePret=='immobilier'}">Immobilier</c:when>
                                                    <c:when test="${demande.typePret=='automobile'}">Automobile</c:when>
                                                    <c:otherwise>${demande.typePret}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                        <div class="info-item">
                                            <span class="info-label">Montant demandé</span>
                                            <span class="info-value highlight">
                                                <fmt:formatNumber value="${demande.montantPret}" type="number"
                                                    maxFractionDigits="0" />€
                                            </span>
                                        </div>
                                        <div class="info-item">
                                            <span class="info-label">Durée</span>
                                            <span class="info-value">${demande.dureeMois} mois</span>
                                        </div>
                                        <div class="info-item">
                                            <span class="info-label">Taux d'intérêt</span>
                                            <span class="info-value">
                                                <fmt:formatNumber value="${demande.tauxInteret}"
                                                    maxFractionDigits="2" />%
                                            </span>
                                        </div>
                                        <div class="info-item">
                                            <span class="info-label">Mensualité</span>
                                            <span class="info-value highlight">
                                                <fmt:formatNumber value="${demande.mensualite}" type="number"
                                                    maxFractionDigits="2" />€
                                            </span>
                                        </div>
                                        <c:if test="${not empty clientInfo}">
                                            <div class="info-item">
                                                <span class="info-label">Taux d'endettement</span>
                                                <span class="info-value">
                                                    <fmt:formatNumber
                                                        value="${(demande.mensualite / clientInfo.revenuMensuel) * 100}"
                                                        maxFractionDigits="1" />%
                                                </span>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>

                            <!-- Right Column - Status & AI Analysis -->
                            <div>
                                <!-- Status Card -->
                                <div class="card">
                                    <div class="card-header">
                                        <i class="fas fa-info-circle"></i>
                                        <h2 class="card-title">Statut</h2>
                                    </div>
                                    <div style="text-align: center; padding: 1rem 0;">
                                        <c:choose>
                                            <c:when test="${demande.statut=='EN_ATTENTE'}">
                                                <span class="badge badge-pending">En attente</span>
                                            </c:when>
                                            <c:when test="${demande.statut=='VALIDE'}">
                                                <span class="badge badge-approved">Validé</span>
                                            </c:when>
                                            <c:when test="${demande.statut=='REJETE'}">
                                                <span class="badge badge-rejected">Rejeté</span>
                                            </c:when>
                                        </c:choose>
                                    </div>

                                    <c:if test="${demande.statut != 'EN_ATTENTE'}">
                                        <div class="info-item" style="margin-top: 1rem;">
                                            <span class="info-label">Traité le</span>
                                            <span class="info-value">
                                                <fmt:formatDate value="${demande.dateDecision}"
                                                    pattern="dd/MM/yyyy HH:mm" />
                                            </span>
                                        </div>
                                    </c:if>
                                </div>

                                <!-- AI Analysis -->
                                <div class="card" style="margin-top: 1.5rem;">
                                    <div class="card-header">
                                        <i class="fas fa-brain"></i>
                                        <h2 class="card-title">Analyse IA</h2>
                                    </div>

                                    <div class="ai-score">
                                        <c:choose>
                                            <c:when test="${prediction != null && prediction.scoreRisque != null}">
                                                <!-- Display actual risk level with color -->
                                                <c:choose>
                                                    <c:when test="${prediction.scoreRisque < 60}">
                                                        <div class="ai-score-value"
                                                            style="background: linear-gradient(135deg, #10b981, #059669); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">
                                                            Faible
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="ai-score-value"
                                                            style="background: linear-gradient(135deg, #ef4444, #dc2626); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">
                                                            Élevé
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <div class="ai-score-label">Niveau de Risque</div>

                                                <!-- Progress bar for risk percentage -->
                                                <div class="progress-bar">
                                                    <c:choose>
                                                        <c:when test="${prediction.scoreRisque < 60}">
                                                            <div class="progress-fill"
                                                                style="width: ${prediction.scoreRisque}%; background: linear-gradient(90deg, #10b981, #059669);">
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="progress-fill"
                                                                style="width: ${prediction.scoreRisque}%; background: linear-gradient(90deg, #ef4444, #dc2626);">
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div
                                                    style="margin-top: 0.5rem; font-size: 0.9rem; color: var(--text-gray);">
                                                    Score: ${prediction.scoreRisque}/100
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="ai-score-value">N/A</div>
                                                <div class="ai-score-label">Score de Risque</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <!-- Structured AI Details -->
                                    <c:if test="${prediction != null && prediction.recommandation != null}">
                                        <div style="margin-top: 2rem;">
                                            <h3
                                                style="font-size: 1rem; font-weight: 700; color: var(--text-gray); text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 1.25rem;">
                                                <i class="fas fa-chart-line" style="margin-right: 0.5rem;"></i>
                                                Détails de l'Analyse
                                            </h3>

                                            <div class="info-grid">
                                                <c:if test="${not empty clientInfo}">
                                                    <div class="info-item">
                                                        <span class="info-label">Ratio d'endettement</span>
                                                        <span class="info-value">
                                                            <fmt:formatNumber
                                                                value="${(demande.mensualite / clientInfo.revenuMensuel) * 100}"
                                                                maxFractionDigits="1" />%
                                                        </span>
                                                    </div>

                                                    <div class="info-item">
                                                        <span class="info-label">Reste à vivre</span>
                                                        <span class="info-value">
                                                            <fmt:formatNumber
                                                                value="${clientInfo.revenuMensuel - demande.mensualite}"
                                                                type="number" maxFractionDigits="0" /> EUR
                                                        </span>
                                                    </div>
                                                </c:if>

                                                <div class="info-item">
                                                    <span class="info-label">Probabilité de défaut</span>
                                                    <span class="info-value">
                                                        <c:choose>
                                                            <c:when test="${prediction.probabiliteDefaut != null}">
                                                                <fmt:formatNumber
                                                                    value="${prediction.probabiliteDefaut * 100}"
                                                                    maxFractionDigits="2" />%
                                                            </c:when>
                                                            <c:otherwise>
                                                                N/A
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </div>

                                                <div class="info-item">
                                                    <span class="info-label">Profil client</span>
                                                    <span class="info-value">
                                                        <c:choose>
                                                            <c:when test="${prediction.scoreRisque < 20}">
                                                                <span style="color: var(--success);">Excellent</span>
                                                            </c:when>
                                                            <c:when test="${prediction.scoreRisque < 40}">
                                                                <span style="color: var(--success);">Bon</span>
                                                            </c:when>
                                                            <c:when test="${prediction.scoreRisque < 60}">
                                                                <span style="color: var(--warning);">Moyen</span>
                                                            </c:when>
                                                            <c:when test="${prediction.scoreRisque < 80}">
                                                                <span style="color: var(--error);">Risqué</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span style="color: var(--error);">Très risqué</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Final Decision -->
                                        <div class="decision-box">
                                            <div class="decision-header">
                                                <i class="fas fa-robot"
                                                    style="font-size: 1.5rem; color: var(--accent-blue);"></i>
                                                <div style="flex: 1;">
                                                    <div class="decision-label">Décision Recommandée</div>
                                                    <div class="decision-value">
                                                        <c:choose>
                                                            <c:when test="${prediction.scoreRisque < 60}">
                                                                <span style="color: var(--success);">
                                                                    <i class="fas fa-check-circle"></i> Validation
                                                                    recommandée
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span style="color: var(--error);">
                                                                    <i class="fas fa-times-circle"></i> Refus recommandé
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>

                                    <c:if test="${prediction == null || prediction.recommandation == null}">
                                        <div class="info-item" style="margin-top: 1.5rem;">
                                            <span class="info-label">Statut</span>
                                            <span class="info-value">En attente d'analyse</span>
                                        </div>
                                    </c:if>
                                </div>

                                <!-- Action Buttons -->
                                <c:if test="${demande.statut == 'EN_ATTENTE'}">
                                    <div class="action-buttons">
                                        <button onclick="validerDemande(${demande.idDemande})" class="btn btn-approve">
                                            <i class="fas fa-check-circle"></i>
                                            Approuver
                                        </button>

                                        <button onclick="refuserDemande(${demande.idDemande})" class="btn btn-reject">
                                            <i class="fas fa-times-circle"></i>
                                            Rejeter
                                        </button>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </main>
                </div>

                <script>
                    // Fonction pour valider une demande
                    function validerDemande(idDemande) {
                        if (!confirm('Êtes-vous sûr de vouloir APPROUVER cette demande ?')) {
                            return;
                        }

                        fetch('${pageContext.request.contextPath}/agent/traiter-demande', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: 'idDemande=' + idDemande + '&action=VALIDE'
                        })
                            .then(response => response.json())
                            .then(data => {
                                if (data.success) {
                                    window.location.reload();
                                } else {
                                    alert('Erreur: ' + (data.error || 'Impossible de valider'));
                                }
                            })
                            .catch(error => {
                                console.error('Erreur:', error);
                                alert('Erreur de connexion');
                            });
                    }

                    // Fonction pour refuser une demande
                    function refuserDemande(idDemande) {
                        if (!confirm('Êtes-vous sûr de vouloir REJETER cette demande ?')) {
                            return;
                        }

                        fetch('${pageContext.request.contextPath}/agent/traiter-demande', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: 'idDemande=' + idDemande + '&action=REJETE'
                        })
                            .then(response => response.json())
                            .then(data => {
                                if (data.success) {
                                    window.location.reload();
                                } else {
                                    alert('Erreur: ' + (data.error || 'Impossible de rejeter'));
                                }
                            })
                            .catch(error => {
                                console.error('Erreur:', error);
                                alert('Erreur de connexion');
                            });
                    }
                </script>
            </body>

            </html>