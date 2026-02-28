<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <fmt:setLocale value="fr_FR" />
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Historique - NeuroBank Agent</title>

                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap"
                    rel="stylesheet">

                <style>
                    /* ===== NEUROBANK MODERN - HISTORIQUE PAGE ===== */
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

                    html {
                        scroll-behavior: smooth;
                    }

                    body {
                        font-family: 'Inter', -apple-system, sans-serif;
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
                        background: var(--success);
                        top: -150px;
                        left: 10%;
                        animation-delay: 0s;
                    }

                    .orb-2 {
                        width: 350px;
                        height: 350px;
                        background: var(--accent-purple);
                        bottom: -50px;
                        right: 15%;
                        animation-delay: 8s;
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

                    /*Sidebar with glassmorphism */
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
                        margin-bottom: 2.5rem;
                        padding-bottom: 1.5rem;
                        border-bottom: 1px solid var(--border-dark);
                        animation: fadeInUp 0.5s ease;
                    }

                    .page-title {
                        font-size: 2.25rem;
                        font-weight: 900;
                        margin-bottom: 0.5rem;
                        background: linear-gradient(135deg, var(--text-white), var(--accent-blue));
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                        letter-spacing: -0.02em;
                    }

                    .page-subtitle {
                        color: var(--text-gray-light);
                        font-size: 1.05rem;
                    }

                    /* Enhanced Stats Grid */
                    .stats-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                        gap: 1.5rem;
                        margin-bottom: 2.5rem;
                    }

                    .stat-card {
                        background: rgba(19, 24, 39, 0.5);
                        backdrop-filter: blur(10px);
                        border: 1px solid var(--border-dark);
                        border-radius: 1.25rem;
                        padding: 2rem;
                        text-align: center;
                        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                        animation: fadeInUp 0.6s ease;
                        animation-fill-mode: both;
                    }

                    .stat-card:nth-child(1) {
                        animation-delay: 0.1s;
                    }

                    .stat-card:nth-child(2) {
                        animation-delay: 0.2s;
                    }

                    .stat-card:nth-child(3) {
                        animation-delay: 0.3s;
                    }

                    .stat-card:hover {
                        transform: translateY(-8px) scale(1.02);
                        border-color: var(--accent-blue);
                        box-shadow: 0 20px 40px rgba(59, 130, 246, 0.25);
                    }

                    .stat-card h3 {
                        font-size: 0.9rem;
                        color: var(--text-gray);
                        margin-bottom: 1rem;
                        text-transform: uppercase;
                        letter-spacing: 0.05em;
                        font-weight: 700;
                    }

                    .stat-card .value {
                        font-size: 2.5rem;
                        font-weight: 900;
                        background: linear-gradient(135deg, var(--text-white), var(--accent-blue));
                        -webkit-background-clip: text;
                        -webkit-text -fill-color: transparent;
                        background-clip: text;
                    }

                    /* Enhanced Table Section */
                    .section {
                        background: rgba(19, 24, 39, 0.5);
                        backdrop-filter: blur(10px);
                        border: 1px solid var(--border-dark);
                        border-radius: 1.25rem;
                        padding: 2rem;
                        overflow-x: auto;
                        animation: fadeInUp 0.7s ease 0.4s both;
                    }

                    .requests-table {
                        width: 100%;
                        border-collapse: collapse;
                    }

                    .requests-table thead tr {
                        border-bottom: 2px solid var(--border-dark);
                    }

                    .requests-table th {
                        padding: 1.25rem;
                        text-align: left;
                        font-weight: 700;
                        color: var(--text-gray);
                        font-size: 0.8rem;
                        text-transform: uppercase;
                        letter-spacing: 0.1em;
                    }

                    .requests-table td {
                        padding: 1.25rem;
                        border-bottom: 1px solid var(--border-dark);
                    }

                    .requests-table tbody tr {
                        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                    }

                    .requests-table tbody tr:hover {
                        background: rgba(59, 130, 246, 0.05);
                        transform: scale(1.005);
                    }

                    /* Enhanced Badges */
                    .badge {
                        padding: 0.5rem 1rem;
                        border-radius: 0.5rem;
                        font-size: 0.8rem;
                        font-weight: 700;
                        display: inline-flex;
                        align-items: center;
                        gap: 0.5rem;
                        text-transform: uppercase;
                        letter-spacing: 0.05em;
                        transition: all 0.3s ease;
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

                    .badge:hover {
                        transform: scale(1.05);
                    }

                    /* Enhanced Buttons */
                    .btn {
                        padding: 0.625rem 1.25rem;
                        border-radius: 0.75rem;
                        text-decoration: none;
                        font-weight: 600;
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        gap: 0.5rem;
                        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                        border: none;
                        cursor: pointer;
                        font-family: inherit;
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
                        width: 300px;
                        height: 300px;
                    }

                    .btn-action {
                        background: rgba(59, 130, 246, 0.1);
                        color: var(--accent-blue);
                        border: 1px solid rgba(59, 130, 246, 0.3);
                        font-size: 0.9rem;
                    }

                    .btn-action:hover {
                        background: var(--accent-blue);
                        color: white;
                        border-color: var(--accent-blue);
                        transform: translateY(-2px);
                        box-shadow: 0 8px 20px rgba(59, 130, 246, 0.3);
                    }

                    .empty-state {
                        text-align: center;
                        padding: 4rem 2rem;
                        color: var(--text-gray);
                    }

                    .empty-state i {
                        font-size: 4rem;
                        margin-bottom: 1.5rem;
                        opacity: 0.3;
                    }

                    .empty-state p {
                        font-size: 1.125rem;
                        font-weight: 600;
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

                        .stats-grid {
                            grid-template-columns: 1fr;
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
                            <a href="${pageContext.request.contextPath}/agent/demandes" class="nav-item">
                                <i class="fas fa-list"></i>
                                Toutes les demandes
                            </a>
                            <a href="${pageContext.request.contextPath}/agent/historique" class="nav-item active">
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
                            <h1 class="page-title">Historique des demandes traitées</h1>
                            <p class="page-subtitle">Consultez toutes les demandes validées et rejetées</p>
                        </div>

                        <!-- Stats -->
                        <div class="stats-grid">
                            <div class="stat-card">
                                <h3><i class="fas fa-check-double"></i> Total traitées</h3>
                                <div class="value">${totalTraitees}</div>
                            </div>
                            <div class="stat-card">
                                <h3><i class="fas fa-check-circle"></i> Validées</h3>
                                <div class="value"
                                    style="background: linear-gradient(135deg, var(--success), #059669); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">
                                    ${totalValidees}</div>
                            </div>
                            <div class="stat-card">
                                <h3><i class="fas fa-times-circle"></i> Rejetées</h3>
                                <div class="value"
                                    style="background: linear-gradient(135deg, var(--error), #dc2626); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">
                                    ${totalRejetees}</div>
                            </div>
                        </div>

                        <!-- Filters -->
                        <div class="filters" style="display: flex; gap: 1rem; margin-bottom: 2rem; flex-wrap: wrap;">
                            <div class="filter-group" style="flex: 1; min-width: 200px;">
                                <label class="filter-label"
                                    style="display: block; margin-bottom: 0.5rem; color: var(--text-gray); font-size: 0.9rem; font-weight: 600;"><i
                                        class="fas fa-filter"></i> Statut</label>
                                <select class="filter-select"
                                    style="width: 100%; padding: 0.75rem; background: rgba(19, 24, 39, 0.5); border: 1px solid var(--border-dark); border-radius: 0.75rem; color: var(--text-white); font-family: inherit;"
                                    onchange="window.location.href='${pageContext.request.contextPath}/agent/historique?statut=' + this.value + '&type=${filtreType}'">
                                    <option value="">Tous les statuts</option>
                                    <option value="VALIDE" ${param.statut=='VALIDE' ? 'selected' : '' }>Validé</option>
                                    <option value="REJETE" ${param.statut=='REJETE' ? 'selected' : '' }>Rejeté</option>
                                </select>
                            </div>

                            <div class="filter-group" style="flex: 1; min-width: 200px;">
                                <label class="filter-label"
                                    style="display: block; margin-bottom: 0.5rem; color: var(--text-gray); font-size: 0.9rem; font-weight: 600;"><i
                                        class="fas fa-tag"></i> Type</label>
                                <select class="filter-select"
                                    style="width: 100%; padding: 0.75rem; background: rgba(19, 24, 39, 0.5); border: 1px solid var(--border-dark); border-radius: 0.75rem; color: var(--text-white); font-family: inherit;"
                                    onchange="window.location.href='${pageContext.request.contextPath}/agent/historique?type=' + this.value + '&statut=${filtreStatut}'">
                                    <option value="">Tous les types</option>
                                    <option value="immobilier" ${param.type=='immobilier' ? 'selected' : '' }>Immobilier
                                    </option>
                                    <option value="automobile" ${param.type=='automobile' ? 'selected' : '' }>Automobile
                                    </option>
                                </select>
                            </div>
                        </div>

                        <!-- Table -->
                        <div class="section">
                            <table class="requests-table">
                                <thead>
                                    <tr>
                                        <th>Date traitement</th>
                                        <th>Client</th>
                                        <th>Type</th>
                                        <th>Montant</th>
                                        <th>Statut</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${historique}" var="d">
                                        <tr>
                                            <td>
                                                <fmt:formatDate value="${d.dateDecision}" pattern="dd/MM/yyyy HH:mm" />
                                            </td>
                                            <td><strong>Client #${d.idClient}</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${d.typePret=='immobilier'}">Immobilier</c:when>
                                                    <c:when test="${d.typePret=='automobile'}">Automobile</c:when>
                                                    <c:otherwise>${d.typePret}</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <strong style="color: var(--accent-blue); font-size: 1.05rem;">
                                                    <fmt:formatNumber value="${d.montantPret}" type="number"
                                                        maxFractionDigits="0" />€
                                                </strong>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${d.statut=='VALIDE'}">
                                                        <span class="badge badge-approved">
                                                            <i class="fas fa-check"></i> Validé
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${d.statut=='REJETE'}">
                                                        <span class="badge badge-rejected">
                                                            <i class="fas fa-times"></i> Rejeté
                                                        </span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/agent/details?id=${d.idDemande}"
                                                    class="btn btn-action">
                                                    <i class="fas fa-eye"></i> Voir
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty historique}">
                                        <tr>
                                            <td colspan="6">
                                                <div class="empty-state">
                                                    <i class="fas fa-inbox"></i>
                                                    <p>Aucun historique disponible</p>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination Controls -->
                        <div class="pagination"
                            style="display: flex; flex-direction: column; align-items: center; gap: 1rem; margin-top: 2rem; padding: 1.5rem 0; border-top: 1px solid var(--border-dark);">
                            <div class="pagination-info" style="color: var(--text-gray); font-size: 0.9rem;">
                                Affichage <strong>${(currentPage - 1) * 10 + 1}</strong> à <strong>${(currentPage - 1) *
                                    10 + historique.size()}</strong> sur <strong>${totalItems}</strong> dossiers
                            </div>

                            <div class="pagination-buttons" style="display: flex; gap: 0.5rem;">
                                <c:if test="${currentPage > 1}">
                                    <a href="?page=1<c:if test='${filtreStatut != null}'>&statut=${filtreStatut}</c:if><c:if test='${filtreType != null}'>&type=${filtreType}</c:if>"
                                        class="pagination-btn"
                                        style="min-width: 40px; height: 40px; display: inline-flex; align-items: center; justify-content: center; background: rgba(255, 255, 255, 0.05); border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 0.5rem; color: var(--text-white); text-decoration: none; transition: all 0.3s ease;">
                                        <i class="fas fa-angle-double-left"></i>
                                    </a>
                                    <a href="?page=${currentPage - 1}<c:if test='${filtreStatut != null}'>&statut=${filtreStatut}</c:if><c:if test='${filtreType != null}'>&type=${filtreType}</c:if>"
                                        class="pagination-btn"
                                        style="min-width: 40px; height: 40px; display: inline-flex; align-items: center; justify-content: center; background: rgba(255, 255, 255, 0.05); border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 0.5rem; color: var(--text-white); text-decoration: none; transition: all 0.3s ease;">
                                        <i class="fas fa-angle-left"></i>
                                    </a>
                                </c:if>

                                <c:forEach begin="${currentPage > 2 ? currentPage - 2 : 1}"
                                    end="${currentPage + 2 < totalPages ? currentPage + 2 : totalPages}" var="i">
                                    <a href="?page=${i}<c:if test='${filtreStatut != null}'>&statut=${filtreStatut}</c:if><c:if test='${filtreType != null}'>&type=${filtreType}</c:if>"
                                        class="pagination-btn ${currentPage == i ? 'active' : ''}"
                                        style="min-width: 40px; height: 40px; display: inline-flex; align-items: center; justify-content: center; border-radius: 0.5rem; text-decoration: none; transition: all 0.3s ease; ${currentPage == i ? 'background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple)); border: 1px solid var(--accent-purple); color: white;' : 'background: rgba(255, 255, 255, 0.05); border: 1px solid rgba(255, 255, 255, 0.1); color: var(--text-white);'}">
                                        ${i}
                                    </a>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <a href="?page=${currentPage + 1}<c:if test='${filtreStatut != null}'>&statut=${filtreStatut}</c:if><c:if test='${filtreType != null}'>&type=${filtreType}</c:if>"
                                        class="pagination-btn"
                                        style="min-width: 40px; height: 40px; display: inline-flex; align-items: center; justify-content: center; background: rgba(255, 255, 255, 0.05); border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 0.5rem; color: var(--text-white); text-decoration: none; transition: all 0.3s ease;">
                                        <i class="fas fa-angle-right"></i>
                                    </a>
                                    <a href="?page=${totalPages}<c:if test='${filtreStatut != null}'>&statut=${filtreStatut}</c:if><c:if test='${filtreType != null}'>&type=${filtreType}</c:if>"
                                        class="pagination-btn"
                                        style="min-width: 40px; height: 40px; display: inline-flex; align-items: center; justify-content: center; background: rgba(255, 255, 255, 0.05); border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 0.5rem; color: var(--text-white); text-decoration: none; transition: all 0.3s ease;">
                                        <i class="fas fa-angle-double-right"></i>
                                    </a>
                                </c:if>
                            </div>
                        </div>

                    </main>
                </div>
            </body>

            </html>