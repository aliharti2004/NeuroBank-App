<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Loan Details - NeuroBank</title>
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
                    rel="stylesheet">
                <style>
                    :root {
                        --bg-dark: #0a0e1a;
                        --bg-card: #131827;
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
                        --sidebar-width: 260px
                    }

                    *,
                    *::before,
                    *::after {
                        box-sizing: border-box;
                        margin: 0;
                        padding: 0
                    }

                    body {
                        font-family: 'Inter', -apple-system, sans-serif;
                        background: var(--bg-dark);
                        color: var(--text-white);
                        line-height: 1.6
                    }

                    .app-layout {
                        display: flex;
                        min-height: 100vh
                    }

                    .sidebar {
                        width: var(--sidebar-width);
                        background: var(--bg-card);
                        border-right: 1px solid var(--border-dark);
                        display: flex;
                        flex-direction: column;
                        position: fixed;
                        height: 100vh;
                        left: 0;
                        top: 0
                    }

                    .sidebar-header {
                        padding: 2rem 1.5rem;
                        border-bottom: 1px solid var(--border-dark)
                    }

                    .logo {
                        display: flex;
                        align-items: center;
                        gap: .75rem
                    }

                    .logo-icon {
                        width: 40px;
                        height: 40px;
                        background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
                        border-radius: .75rem;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 1.25rem;
                        color: white
                    }

                    .logo-text {
                        font-size: 1.25rem;
                        font-weight: 800;
                        background: linear-gradient(135deg, var(--text-white), var(--text-gray-light));
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent
                    }

                    .sidebar-nav {
                        flex: 1;
                        padding: 1.5rem 1rem;
                        display: flex;
                        flex-direction: column;
                        gap: .5rem
                    }

                    .nav-item {
                        display: flex;
                        align-items: center;
                        gap: .75rem;
                        padding: .875rem 1rem;
                        color: var(--text-gray);
                        text-decoration: none;
                        border-radius: .75rem;
                        transition: all .3s ease;
                        font-weight: 500
                    }

                    .nav-item:hover {
                        background: var(--bg-input);
                        color: var(--text-white)
                    }

                    .nav-item.active {
                        background: rgba(59, 130, 246, .1);
                        color: var(--accent-blue)
                    }

                    .nav-item i {
                        font-size: 1.125rem
                    }

                    .nav-item.logout {
                        margin-top: auto;
                        color: var(--error)
                    }

                    .nav-item.logout:hover {
                        background: rgba(239, 68, 68, .1)
                    }

                    .main-content {
                        margin-left: var(--sidebar-width);
                        flex: 1;
                        padding: 2rem;
                        max-width: calc(100% - var(--sidebar-width))
                    }

                    .page-header {
                        margin-bottom: 2rem;
                        display: flex;
                        align-items: center;
                        justify-content: space-between
                    }

                    .page-title {
                        font-size: 2rem;
                        font-weight: 800;
                        margin-bottom: .5rem
                    }

                    .page-subtitle {
                        color: var(--text-gray);
                        font-size: 1rem
                    }

                    .grid-layout {
                        display: grid;
                        grid-template-columns: 2fr 1fr;
                        gap: 1.5rem
                    }

                    .card {
                        background: var(--bg-card);
                        border: 1px solid var(--border-dark);
                        border-radius: 1rem;
                        overflow: hidden;
                        margin-bottom: 1.5rem
                    }

                    .card-header {
                        padding: 1.5rem;
                        border-bottom: 1px solid var(--border-dark)
                    }

                    .card-title {
                        font-size: 1.25rem;
                        font-weight: 700
                    }

                    .card-body {
                        padding: 2rem
                    }

                    .detail-grid {
                        display: grid;
                        gap: 1.25rem
                    }

                    .detail-item-label {
                        color: var(--text-gray);
                        font-size: .9rem;
                        margin-bottom: .25rem
                    }

                    .detail-item-value {
                        font-size: 1.1rem;
                        font-weight: 600
                    }

                    .badge {
                        display: inline-flex;
                        align-items: center;
                        gap: .5rem;
                        padding: .5rem 1rem;
                        border-radius: .5rem;
                        font-size: .875rem;
                        font-weight: 600
                    }

                    .badge-warning {
                        background: rgba(245, 158, 11, .1);
                        color: var(--warning);
                        border: 1px solid rgba(245, 158, 11, .3)
                    }

                    .badge-success {
                        background: rgba(16, 185, 129, .1);
                        color: var(--success);
                        border: 1px solid rgba(16, 185, 129, .3)
                    }

                    .badge-danger {
                        background: rgba(239, 68, 68, .1);
                        color: var(--error);
                        border: 1px solid rgba(239, 68, 68, .3)
                    }

                    .btn {
                        display: inline-flex;
                        align-items: center;
                        gap: .75rem;
                        padding: .875rem 1.75rem;
                        color: white;
                        text-decoration: none;
                        border-radius: .75rem;
                        font-weight: 600;
                        font-size: 1rem;
                        transition: all .3s ease;
                        border: none;
                        cursor: pointer;
                        font-family: 'Inter', sans-serif
                    }

                    .btn-primary {
                        background: linear-gradient(135deg, var(--accent-blue), var(--accent-blue-dark));
                        box-shadow: 0 4px 15px rgba(59, 130, 246, .3)
                    }

                    .btn-primary:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 8px 25px rgba(59, 130, 246, .4)
                    }

                    .btn-secondary {
                        background: var(--bg-input);
                        color: var(--text-gray-light);
                        border: 1px solid var(--border-dark);
                        box-shadow: none
                    }

                    .btn-secondary:hover {
                        background: var(--bg-card);
                        color: var(--text-white);
                        border-color: var(--accent-blue)
                    }

                    @media (max-width:1024px) {
                        .grid-layout {
                            grid-template-columns: 1fr
                        }
                    }

                    @media (max-width:768px) {
                        .sidebar {
                            width: 80px
                        }

                        .logo-text,
                        .nav-item span {
                            display: none
                        }

                        .main-content {
                            margin-left: 80px;
                            max-width: calc(100% - 80px)
                        }

                        .page-header {
                            flex-direction: column;
                            align-items: flex-start;
                            gap: 1rem
                        }
                    }
                </style>
            </head>

            <body>
                <div class="app-layout">
                    <aside class="sidebar">
                        <div class="sidebar-header">
                            <div class="logo">
                                <div class="logo-icon"><i class="fas fa-brain"></i></div>
                                <div class="logo-text">NeuroBank</div>
                            </div>
                        </div>
                        <nav class="sidebar-nav">
                            <a href="<%=request.getContextPath()%>/client/dashboard" class="nav-item active">
                                <i class="fas fa-home"></i><span>Tableau de bord</span>
                            </a>
                            <a href="<%=request.getContextPath()%>/client/nouveau_pret" class="nav-item">
                                <i class="fas fa-plus-circle"></i><span>Nouvelle demande</span>
                            </a>
                            <a href="<%=request.getContextPath()%>/client/profil" class="nav-item">
                                <i class="fas fa-user"></i><span>Profil</span>
                            </a>
                            <a href="<%=request.getContextPath()%>/logout" class="nav-item logout">
                                <i class="fas fa-sign-out-alt"></i><span>Déconnexion</span>
                            </a>
                        </nav>
                    </aside>

                    <main class="main-content">
                        <div class="page-header">
                            <div>
                                <h1 class="page-title">Loan Application #${demande.idDemande}</h1>
                                <p class="page-subtitle">
                                    <fmt:formatDate value="${demande.dateCreation}"
                                        pattern="EEEE, MMMM dd yyyy 'at' HH:mm" />
                                </p>
                            </div>
                            <a href="<%=request.getContextPath()%>/client/dashboard" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Back
                            </a>
                        </div>

                        <div class="grid-layout">
                            <div>
                                <div class="card">
                                    <div class="card-header">
                                        <h2 class="card-title"><i class="fas fa-file-invoice-dollar"></i> Loan
                                            Information</h2>
                                    </div>
                                    <div class="card-body">
                                        <div class="detail-grid">
                                            <div>
                                                <div class="detail-item-label">Type de prêt</div>
                                                <div class="detail-item-value">
                                                    <c:choose>
                                                        <c:when test="${demande.typePret=='immobilier'}">Immobilier
                                                        </c:when>
                                                        <c:when test="${demande.typePret=='automobile'}">Prêt automobile
                                                        </c:when>
                                                        <c:otherwise>${demande.typePret}</c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            <div>
                                                <div class="detail-item-label">Montant</div>
                                                <div class="detail-item-value" style="color:var(--accent-blue)">
                                                    <fmt:formatNumber value="${demande.montantPret}" type="number"
                                                        maxFractionDigits="0" />€
                                                </div>
                                            </div>
                                            <div>
                                                <div class="detail-item-label">Durée</div>
                                                <div class="detail-item-value">${demande.dureeMois} months</div>
                                            </div>
                                            <div>
                                                <div class="detail-item-label">Taux d'intérêt</div>
                                                <div class="detail-item-value">
                                                    <fmt:formatNumber value="${demande.tauxInteret}"
                                                        maxFractionDigits="2" />%
                                                </div>
                                            </div>
                                            <div>
                                                <div class="detail-item-label">Mensualité</div>
                                                <div class="detail-item-value" style="color:var(--success)">
                                                    <fmt:formatNumber value="${demande.mensualite}" type="number"
                                                        maxFractionDigits="2" />€
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <%-- AI Analysis hidden from client view --%>
                            </div>

                            <div>
                                <div class="card">
                                    <div class="card-header">
                                        <h2 class="card-title"><i class="fas fa-info-circle"></i> Application Status
                                        </h2>
                                    </div>
                                    <div class="card-body">
                                        <div style="text-align:center;margin-bottom:1.5rem">
                                            <c:choose>
                                                <c:when test="${demande.statut=='EN_ATTENTE'}">
                                                    <span class="badge badge-warning"
                                                        style="font-size:1rem;padding:.75rem 1.5rem">
                                                        <i class="fas fa-clock"></i> Pending Review
                                                    </span>
                                                </c:when>
                                                <c:when test="${demande.statut=='VALIDE'}">
                                                    <span class="badge badge-success"
                                                        style="font-size:1rem;padding:.75rem 1.5rem">
                                                        <i class="fas fa-check-circle"></i> Approved
                                                    </span>
                                                </c:when>
                                                <c:when test="${demande.statut=='REJETE'}">
                                                    <span class="badge badge-danger"
                                                        style="font-size:1rem;padding:.75rem 1.5rem">
                                                        <i class="fas fa-times-circle"></i> Rejected
                                                    </span>
                                                </c:when>
                                            </c:choose>
                                        </div>

                                        <div class="detail-grid" style="gap:.75rem">
                                            <div>
                                                <div class="detail-item-label">Soumise le</div>
                                                <div style="font-size:.95rem">
                                                    <fmt:formatDate value="${demande.dateCreation}"
                                                        pattern="dd/MM/yyyy HH:mm" />
                                                </div>
                                            </div>
                                            <c:if test="${demande.dateDecision != null}">
                                                <div>
                                                    <div class="detail-item-label">Decision Date</div>
                                                    <div style="font-size:.95rem">
                                                        <fmt:formatDate value="${demande.dateDecision}"
                                                            pattern="dd/MM/yyyy HH:mm" />
                                                    </div>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>

                                <div class="card"
                                    style="background:rgba(59,130,246,.05);border-color:rgba(59,130,246,.2)">
                                    <div class="card-body">
                                        <div style="text-align:center">
                                            <i class="fas fa-info-circle"
                                                style="font-size:2rem;color:var(--accent-blue);margin-bottom:.75rem"></i>
                                            <h3 style="font-size:1.1rem;margin-bottom:.5rem">What's Next?</h3>
                                            <p style="color:var(--text-gray);font-size:.95rem;margin:0;line-height:1.6">
                                                <c:choose>
                                                    <c:when test="${demande.statut=='EN_ATTENTE'}">
                                                        Your application is being reviewed by our loan officers. You'll
                                                        receive a notification once a decision is made.
                                                    </c:when>
                                                    <c:when test="${demande.statut=='VALIDE'}">
                                                        Congratulations! Your loan has been approved. Our team will
                                                        contact you soon with next steps.
                                                    </c:when>
                                                    <c:when test="${demande.statut=='REJETE'}">
                                                        Unfortunately, your application was not approved. You can submit
                                                        a new application with adjusted parameters.
                                                    </c:when>
                                                </c:choose>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>
                </div>
            </body>

            </html>