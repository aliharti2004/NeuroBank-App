<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <fmt:setLocale value="fr_FR" />
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Dashboard - NeuroBank</title>

                <!-- Icons -->
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

                <!-- Fonts -->
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
                    rel="stylesheet">

                <style>
                    :root {
                        --bg-dark: #0a0e1a;
                        --bg-card: # 131827;
                        --bg-input: #1a1f35;
                        --accent-blue: #3b82f6;
                        --accent-blue-dark: #2563eb;
                        --accent-purple: #8b5cf6;
                        --text-white: #ffffff;
                        --text-gray: #94a3b8;
                        --text-gray-light: #cbd5e1;
                        --border-dark: #1e293b;
                        --success: #10b981;
                        --warning: #f59e0b;
                        --error: #ef4444;
                        --sidebar-width: 260px;
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

                    /* Layout */
                    .app-layout {
                        display: flex;
                        min-height: 100vh;
                    }

                    /* Sidebar */
                    .sidebar {
                        width: var(--sidebar-width);
                        background: var(--bg-card);
                        border-right: 1px solid var(--border-dark);
                        display: flex;
                        flex-direction: column;
                        position: fixed;
                        height: 100vh;
                        left: 0;
                        top: 0;
                    }

                    .sidebar-header {
                        padding: 2rem 1.5rem;
                        border-bottom: 1px solid var(--border-dark);
                    }

                    .logo {
                        display: flex;
                        align-items: center;
                        gap: 0.75rem;
                    }

                    .logo-icon {
                        width: 40px;
                        height: 40px;
                        background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
                        border-radius: 0.75rem;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 1.25rem;
                        color: white;
                    }

                    .logo-text {
                        font-size: 1.25rem;
                        font-weight: 800;
                        background: linear-gradient(135deg, var(--text-white), var(--text-gray-light));
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                    }

                    .sidebar-nav {
                        flex: 1;
                        padding: 1.5rem 1rem;
                        display: flex;
                        flex-direction: column;
                        gap: 0.5rem;
                    }

                    .nav-item {
                        display: flex;
                        align-items: center;
                        gap: 0.75rem;
                        padding: 0.875rem 1rem;
                        color: var(--text-gray);
                        text-decoration: none;
                        border-radius: 0.75rem;
                        transition: all 0.3s ease;
                        font-weight: 500;
                    }

                    .nav-item:hover {
                        background: var(--bg-input);
                        color: var(--text-white);
                    }

                    .nav-item.active {
                        background: rgba(59, 130, 246, 0.1);
                        color: var(--accent-blue);
                    }

                    .nav-item i {
                        font-size: 1.125rem;
                    }

                    .nav-item.logout {
                        margin-top: auto;
                        color: var(--error);
                    }

                    .nav-item.logout:hover {
                        background: rgba(239, 68, 68, 0.1);
                    }

                    /* Main Content */
                    .main-content {
                        margin-left: var(--sidebar-width);
                        flex: 1;
                        padding: 2rem;
                        max-width: calc(100% - var(--sidebar-width));
                    }

                    /* Page Header */
                    .page-header {
                        margin-bottom: 2rem;
                    }

                    .page-title {
                        font-size: 2rem;
                        font-weight: 800;
                        margin-bottom: 0.5rem;
                    }

                    .page-subtitle {
                        color: var(--text-gray);
                        font-size: 1rem;
                    }

                    /* Alert */
                    .alert {
                        padding: 1.25rem 1.5rem;
                        border-radius: 0.75rem;
                        margin-bottom: 2rem;
                        display: flex;
                        align-items: center;
                        gap: 1rem;
                        animation: slide-in 0.4s ease;
                    }

                    @keyframes slide-in {
                        from {
                            opacity: 0;
                            transform: translateY(-10px);
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }

                    .alert-warning {
                        background: rgba(245, 158, 11, 0.1);
                        border: 1px solid rgba(245, 158, 11, 0.3);
                        color: var(--warning);
                    }

                    .alert-icon {
                        font-size: 1.5rem;
                    }

                    .alert-content {
                        flex: 1;
                    }

                    .alert-title {
                        font-weight: 600;
                        margin-bottom: 0.25rem;
                    }

                    /* Stats Grid */
                    .stats-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                        gap: 1.5rem;
                        margin-bottom: 2rem;
                    }

                    .stat-card {
                        background: var(--bg-card);
                        border: 1px solid var(--border-dark);
                        border-radius: 1rem;
                        padding: 1.75rem;
                        transition: all 0.3s ease;
                        position: relative;
                        overflow: hidden;
                    }

                    .stat-card::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        height: 3px;
                        background: linear-gradient(90deg, var(--accent-blue), var(--accent-purple));
                        transform: scaleX(0);
                        transition: transform 0.3s ease;
                    }

                    .stat-card:hover {
                        transform: translateY(-4px);
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                    }

                    .stat-card:hover::before {
                        transform: scaleX(1);
                    }

                    .stat-header {
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                        margin-bottom: 1rem;
                    }

                    .stat-icon {
                        width: 50px;
                        height: 50px;
                        background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
                        border-radius: 0.75rem;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 1.5rem;
                        color: white;
                    }

                    .stat-value {
                        font-size: 2rem;
                        font-weight: 800;
                        color: var(--text-white);
                    }

                    .stat-label {
                        color: var(--text-gray);
                        font-size: 0.95rem;
                    }

                    /* Action Button */
                    .action-btn {
                        display: inline-flex;
                        align-items: center;
                        gap: 0.75rem;
                        padding: 1rem 2rem;
                        background: linear-gradient(135deg, var(--accent-blue), var(--accent-blue-dark));
                        color: white;
                        text-decoration: none;
                        border-radius: 0.75rem;
                        font-weight: 600;
                        font-size: 1.05rem;
                        transition: all 0.3s ease;
                        box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
                        margin-bottom: 2rem;
                    }

                    .action-btn:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 8px 25px rgba(59, 130, 246, 0.4);
                    }

                    /* Card */
                    .card {
                        background: var(--bg-card);
                        border: 1px solid var(--border-dark);
                        border-radius: 1rem;
                        overflow: hidden;
                        margin-bottom: 2rem;
                    }

                    .card-header {
                        padding: 1.5rem;
                        border-bottom: 1px solid var(--border-dark);
                    }

                    .card-title {
                        font-size: 1.25rem;
                        font-weight: 700;
                    }

                    .card-body {
                        padding: 1.5rem;
                    }

                    /* Table */
                    .table-container {
                        overflow-x: auto;
                    }

                    .table {
                        width: 100%;
                        border-collapse: collapse;
                    }

                    .table thead {
                        background: var(--bg-input);
                    }

                    .table th {
                        padding: 1rem;
                        text-align: left;
                        font-weight: 600;
                        font-size: 0.875rem;
                        color: var(--text-gray-light);
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                    }

                    .table tbody tr {
                        border-bottom: 1px solid var(--border-dark);
                        transition: background 0.3s ease;
                    }

                    .table tbody tr:hover {
                        background: var(--bg-input);
                    }

                    .table td {
                        padding: 1rem;
                        color: var(--text-gray-light);
                    }

                    /* Badge */
                    .badge {
                        display: inline-flex;
                        align-items: center;
                        gap: 0.5rem;
                        padding: 0.5rem 1rem;
                        border-radius: 0.5rem;
                        font-size: 0.875rem;
                        font-weight: 600;
                    }

                    .badge-warning {
                        background: rgba(245, 158, 11, 0.1);
                        color: var(--warning);
                        border: 1px solid rgba(245, 158, 11, 0.3);
                    }

                    .badge-success {
                        background: rgba(16, 185, 129, 0.1);
                        color: var(--success);
                        border: 1px solid rgba(16, 185, 129, 0.3);
                    }

                    .badge-danger {
                        background: rgba(239, 68, 68, 0.1);
                        color: var(--error);
                        border: 1px solid rgba(239, 68, 68, 0.3);
                    }

                    /* Button */
                    .btn {
                        display: inline-flex;
                        align-items: center;
                        gap: 0.5rem;
                        padding: 0.625rem 1.25rem;
                        background: var(--bg-input);
                        color: var(--text-gray-light);
                        text-decoration: none;
                        border-radius: 0.5rem;
                        font-weight: 500;
                        font-size: 0.95rem;
                        transition: all 0.3s ease;
                        border: 1px solid var(--border-dark);
                    }

                    .btn:hover {
                        background: var(--bg-card);
                        color: var(--text-white);
                        border-color: var(--accent-blue);
                    }

                    .btn-primary {
                        background: var(--accent-blue);
                        color: white;
                        border-color: var(--accent-blue);
                    }

                    .btn-primary:hover {
                        background: var(--accent-blue-dark);
                    }

                    /* Empty State */
                    .empty-state {
                        text-align: center;
                        padding: 4rem 2rem;
                    }

                    .empty-state-icon {
                        width: 100px;
                        height: 100px;
                        background: var(--bg-input);
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 3rem;
                        margin: 0 auto 1.5rem;
                    }

                    .empty-state-title {
                        font-size: 1.5rem;
                        font-weight: 700;
                        margin-bottom: 0.5rem;
                    }

                    .empty-state-text {
                        color: var(--text-gray);
                        margin-bottom: 2rem;
                    }

                    /* Responsive */
                    @media (max-width: 768px) {
                        .sidebar {
                            width: 80px;
                        }

                        .sidebar-header {
                            padding: 1.5rem 1rem;
                        }

                        .logo-text,
                        .nav-item span {
                            display: none;
                        }

                        .main-content {
                            margin-left: 80px;
                            max-width: calc(100% - 80px);
                        }

                        .stats-grid {
                            grid-template-columns: 1fr;
                        }
                    }
                </style>
            </head>

            <body>
                <div class="app-layout">
                    <!-- Sidebar -->
                    <aside class="sidebar">
                        <div class="sidebar-header">
                            <div class="logo">
                                <div class="logo-icon">
                                    <i class="fas fa-brain"></i>
                                </div>
                                <div class="logo-text">NeuroBank</div>
                            </div>
                        </div>

                        <nav class="sidebar-nav">
                            <a href="<%= request.getContextPath() %>/client/dashboard" class="nav-item active">
                                <i class="fas fa-home"></i>
                                <span>Tableau de bord</span>
                            </a>
                            <a href="<%= request.getContextPath() %>/client/nouveau_pret" class="nav-item">
                                <i class="fas fa-plus-circle"></i>
                                <span>Nouvelle demande</span>
                            </a>
                            <a href="<%= request.getContextPath() %>/client/profil" class="nav-item">
                                <i class="fas fa-user"></i>
                                <span>Profil</span>
                            </a>
                            <a href="<%= request.getContextPath() %>/logout" class="nav-item logout">
                                <i class="fas fa-sign-out-alt"></i>
                                <span>Déconnexion</span>
                            </a>
                        </nav>
                    </aside>

                    <!-- Main Content -->
                    <main class="main-content">
                        <!-- Page Header -->
                        <div class="page-header">
                            <h1 class="page-title">Bienvenue, ${sessionScope.user.prenom} ${sessionScope.user.nom}
                            </h1>
                            <p class="page-subtitle">
                                <fmt:formatDate value="<%= new java.util.Date() %>" pattern="EEEE dd MMMM yyyy" />
                            </p>
                        </div>

                        <!-- Alert: Incomplete Profile -->
                        <c:if test="${client == null}">
                            <div class="alert alert-warning">
                                <div class="alert-icon">
                                    <i class="fas fa-exclamation-triangle"></i>
                                </div>
                                <div class="alert-content">
                                    <div class="alert-title">Profil incomplet</div>
                                    <div>Complétez votre profil financier pour soumettre des demandes de prêt.</div>
                                </div>
                                <a href="<%= request.getContextPath() %>/client/profil" class="btn btn-primary">
                                    Compléter le profil
                                </a>
                            </div>
                        </c:if>

                        <!-- Stats Grid -->
                        <div class="stats-grid">
                            <div class="stat-card">
                                <div class="stat-header">
                                    <div class="stat-icon">
                                        <i class="fas fa-file-alt"></i>
                                    </div>
                                </div>
                                <div class="stat-value">${totalDemandes}</div>
                                <div class="stat-label">Demandes totales</div>
                            </div>

                            <div class="stat-card">
                                <div class="stat-header">
                                    <div class="stat-icon">
                                        <i class="fas fa-euro-sign"></i>
                                    </div>
                                </div>
                                <div class="stat-value">
                                    <fmt:formatNumber value="${montantTotal}" type="number" maxFractionDigits="0" />€
                                </div>
                                <div class="stat-label">Montant total demandé</div>
                            </div>

                            <div class="stat-card">
                                <div class="stat-header">
                                    <div class="stat-icon">
                                        <i class="fas fa-clock"></i>
                                    </div>
                                </div>
                                <div class="stat-value">${enAttente}</div>
                                <div class="stat-label">En attente</div>
                            </div>
                        </div>

                        <!-- New Loan Button -->
                        <c:if test="${client != null}">
                            <a href="<%= request.getContextPath() %>/client/nouveau_pret" class="action-btn">
                                <i class="fas fa-plus"></i>
                                Nouvelle demande de prêt
                            </a>
                        </c:if>

                        <!-- Loans Table -->
                        <c:if test="${demandes != null && demandes.size() > 0}">
                            <div class="card">
                                <div class="card-header">
                                    <h2 class="card-title">Mes demandes de prêt</h2>
                                </div>
                                <div class="card-body">
                                    <div class="table-container">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>Date</th>
                                                    <th>Type</th>
                                                    <th>Montant</th>
                                                    <th>Durée</th>
                                                    <th>Mensualité</th>
                                                    <th>Statut</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="demande" items="${demandes}">
                                                    <tr>
                                                        <td>
                                                            <fmt:formatDate value="${demande.dateCreation}"
                                                                pattern="dd/MM/yyyy" />
                                                        </td>
                                                        <td><strong>${demande.typePret}</strong></td>
                                                        <td>
                                                            <strong>
                                                                <fmt:formatNumber value="${demande.montantPret}"
                                                                    type="number" maxFractionDigits="0" />€
                                                            </strong>
                                                        </td>
                                                        <td>${demande.dureeMois} mois</td>
                                                        <td>
                                                            <fmt:formatNumber value="${demande.mensualite}"
                                                                type="number" maxFractionDigits="2" />€
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${demande.statut == 'EN_ATTENTE'}">
                                                                    <span class="badge badge-warning">
                                                                        <i class="fas fa-clock"></i> En attente
                                                                    </span>
                                                                </c:when>
                                                                <c:when test="${demande.statut == 'VALIDE'}">
                                                                    <span class="badge badge-success">
                                                                        <i class="fas fa-check-circle"></i> Validé
                                                                    </span>
                                                                </c:when>
                                                                <c:when test="${demande.statut == 'REJETE'}">
                                                                    <span class="badge badge-danger">
                                                                        <i class="fas fa-times-circle"></i> Rejeté
                                                                    </span>
                                                                </c:when>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <a href="<%= request.getContextPath() %>/client/detail_pret?id=${demande.idDemande}"
                                                                class="btn">
                                                                <i class="fas fa-eye"></i> Voir
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <!-- Empty State -->
                        <c:if test="${demandes == null || demandes.size() == 0}">
                            <div class="card">
                                <div class="card-body">
                                    <div class="empty-state">
                                        <div class="empty-state-icon">
                                            <i class="fas fa-folder-open"></i>
                                        </div>
                                        <h3 class="empty-state-title">Aucune demande de prêt</h3>
                                        <p class="empty-state-text">
                                            Vous n'avez pas encore soumis de demande de prêt. Commencez par créer votre
                                            première demande.
                                        </p>
                                        <c:if test="${client != null}">
                                            <a href="<%= request.getContextPath() %>/client/nouveau_pret"
                                                class="action-btn">
                                                <i class="fas fa-plus"></i>
                                                Créer ma première demande
                                            </a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </main>
                </div>

                <script>
                    // Add animation on page load
                    document.addEventListener('DOMContentLoaded', function () {
                        const cards = document.querySelectorAll('.stat-card');
                        cards.forEach((card, index) => {
                            setTimeout(() => {
                                card.style.animation = 'slide-in 0.5s ease';
                            }, index * 100);
                        });
                    });

                    // Add hover effect for table rows
                    document.querySelectorAll('.table tbody tr').forEach(row => {
                        row.addEventListener('click', function (e) {
                            if (!e.target.closest('.btn')) {
                                const link = this.querySelector('a[href*="detail_pret"]');
                                if (link) {
                                    window.location.href = link.href;
                                }
                            }
                        });

                        row.style.cursor = 'pointer';
                    });
                </script>
            </body>

            </html>