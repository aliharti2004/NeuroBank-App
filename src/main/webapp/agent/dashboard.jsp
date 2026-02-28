<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>Dashboard Agent - BankLoan</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=3">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
                <style>
                    /* Styles inlines de secours pour garantir l'affichage */
                    :root {
                        --bg-secondary: #151b3d;
                        --border-color: #334155;
                        --radius-lg: 0.75rem;
                        --spacing-md: 1.5rem;
                    }

                    .stats-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
                        gap: 1.5rem;
                        margin-bottom: 2rem;
                    }

                    .stat-card {
                        background: #151b3d;
                        border: 1px solid #334155;
                        border-radius: 0.75rem;
                        padding: 1.5rem;
                        display: flex;
                        align-items: center;
                        gap: 1.5rem;
                        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.4);
                        color: #f8fafc;
                    }

                    .stat-icon {
                        width: 60px;
                        height: 60px;
                        border-radius: 0.5rem;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 1.75rem;
                        flex-shrink: 0;
                    }

                    .stat-icon.combined {
                        background: rgba(59, 130, 246, 0.1);
                        color: #3b82f6;
                    }

                    .stat-icon.immobilier {
                        background: rgba(16, 185, 129, 0.1);
                        color: #10b981;
                    }

                    .stat-icon.automobile {
                        background: rgba(139, 92, 246, 0.1);
                        color: #8b5cf6;
                    }

                    .stat-info {
                        display: flex;
                        flex-direction: column;
                    }

                    .stat-info h3 {
                        font-size: 0.9rem;
                        color: #94a3b8;
                        margin-bottom: 0.25rem;
                        font-weight: 500;
                    }

                    .stat-value {
                        font-size: 1.75rem;
                        font-weight: 700;
                        color: #f8fafc;
                        margin: 0;
                    }

                    .recent-requests {
                        background: #151b3d;
                        border: 1px solid #334155;
                        border-radius: 0.75rem;
                        padding: 1.5rem;
                        margin-top: 2rem;
                    }

                    .section-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 1.5rem;
                    }

                    .section-header h2 {
                        font-size: 1.25rem;
                        color: #f8fafc;
                        margin: 0;
                    }

                    .requests-table {
                        width: 100%;
                        border-collapse: collapse;
                    }

                    .requests-table th {
                        text-align: left;
                        padding: 1rem;
                        color: #94a3b8;
                        border-bottom: 1px solid #334155;
                        font-weight: 600;
                        text-transform: uppercase;
                        font-size: 0.85rem;
                    }

                    .requests-table td {
                        padding: 1rem;
                        border-bottom: 1px solid #334155;
                        vertical-align: middle;
                        color: #f8fafc;
                    }

                    .badge {
                        padding: 0.25rem 0.75rem;
                        border-radius: 999px;
                        font-size: 0.85rem;
                        font-weight: 600;
                    }

                    .badge-warning {
                        background: rgba(245, 158, 11, 0.2);
                        color: #f59e0b;
                    }

                    .btn-action {
                        color: #3b82f6;
                        background: rgba(59, 130, 246, 0.1);
                        padding: 0.5rem 1rem;
                        border-radius: 0.5rem;
                        text-decoration: none;
                        font-size: 0.9rem;
                        font-weight: 500;
                        display: inline-flex;
                        align-items: center;
                        gap: 0.5rem;
                    }

                    .btn-action:hover {
                        background: #3b82f6;
                        color: white;
                    }

                    .btn-outline {
                        border: 1px solid #3b82f6;
                        color: #3b82f6;
                        padding: 0.5rem 1rem;
                        border-radius: 0.5rem;
                        text-decoration: none;
                    }

                    .btn-outline:hover {
                        background: rgba(59, 130, 246, 0.1);
                    }
                </style>
            </head>

            <body>
                <div class="dashboard-container">
                    <!-- Sidebar -->
                    <aside class="sidebar">
                        <div class="logo">
                            <i class="fas fa-landmark"></i>
                            <span>BankLoan Agent</span>
                        </div>

                        <nav class="nav-links">
                            <a href="${pageContext.request.contextPath}/agent/dashboard" class="nav-item active">
                                <i class="fas fa-chart-line"></i> Dashboard
                            </a>
                            <a href="${pageContext.request.contextPath}/agent/demandes" class="nav-item">
                                <i class="fas fa-list"></i> Toutes les demandes
                            </a>
                            <a href="${pageContext.request.contextPath}/agent/historique" class="nav-item">
                                <i class="fas fa-history"></i> Historique
                            </a>
                            <a href="${pageContext.request.contextPath}/logout" class="nav-item logout">
                                <i class="fas fa-sign-out-alt"></i> Déconnexion
                            </a>
                        </nav>
                    </aside>

                    <!-- Main Content -->
                    <main class="main-content">
                        <header class="top-bar">
                            <div class="user-info">
                                <span>Bonjour, Agent <strong>${sessionScope.user.nom}</strong></span>
                                <i class="fas fa-user-tie"></i>
                            </div>
                        </header>

                        <div class="dashboard-content">
                            <div class="stats-grid">
                                <div class="stat-card">
                                    <div class="stat-icon combined">
                                        <i class="fas fa-bell"></i>
                                    </div>
                                    <div class="stat-info">
                                        <h3>En Attente</h3>
                                        <p class="stat-value">${statEnAttente}</p>
                                    </div>
                                </div>

                                <div class="stat-card">
                                    <div class="stat-icon immobilier">
                                        <i class="fas fa-check-circle"></i>
                                    </div>
                                    <div class="stat-info">
                                        <h3>Traitées (Total)</h3>
                                        <p class="stat-value">${statTraitees}</p>
                                    </div>
                                </div>

                                <div class="stat-card">
                                    <div class="stat-icon automobile">
                                        <i class="fas fa-percentage"></i>
                                    </div>
                                    <div class="stat-info">
                                        <h3>Taux Approbation</h3>
                                        <p class="stat-value">${statTauxApprobation}%</p>
                                    </div>
                                </div>
                            </div>

                            <div class="recent-requests">
                                <div class="section-header">
                                    <h2>⚠️ À Traiter (Urgent)</h2>
                                    <a href="${pageContext.request.contextPath}/agent/demandes?statut=EN_ATTENTE"
                                        class="btn btn-outline">Voir tout</a>
                                </div>

                                <table class="requests-table">
                                    <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Client #</th>
                                            <th>Type</th>
                                            <th>Montant</th>
                                            <th>Score IA</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${demandesUrgentes}" var="d">
                                            <tr>
                                                <td>
                                                    <fmt:formatDate value="${d.dateCreation}" pattern="dd/MM/yyyy" />
                                                </td>
                                                <td>${d.idClient}</td>
                                                <td>${d.typePret}</td>
                                                <td>
                                                    <fmt:formatNumber value="${d.montantPret}" type="currency"
                                                        currencySymbol="€" />
                                                </td>
                                                <td>
                                                    <!-- Placeholder score, à implémenter si dispo dans objet -->
                                                    <span class="badge badge-warning">À Analyser</span>
                                                </td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/agent/details?id=${d.idDemande}"
                                                        class="btn-action">
                                                        <i class="fas fa-eye"></i> Traiter
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty demandesUrgentes}">
                                            <tr>
                                                <td colspan="6" style="text-align: center; padding: 2rem;">
                                                    ✅ Aucune demande en attente !
                                                </td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </main>
                </div>
            </body>

            </html>