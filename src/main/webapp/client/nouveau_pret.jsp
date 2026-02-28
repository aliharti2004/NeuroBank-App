<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Nouvelle demande - NeuroBank</title>
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
                rel="stylesheet">
            <style>
                /* Same core styles as other pages - keeping consistency */
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
                    margin-bottom: 2rem
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

                .alert {
                    padding: 1.25rem 1.5rem;
                    border-radius: .75rem;
                    margin-bottom: 2rem;
                    display: flex;
                    align-items: center;
                    gap: 1rem;
                    animation: slide-in .4s ease
                }

                @keyframes slide-in {
                    from {
                        opacity: 0;
                        transform: translateY(-10px)
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0)
                    }
                }

                .alert-danger {
                    background: rgba(239, 68, 68, .1);
                    border: 1px solid rgba(239, 68, 68, .3);
                    color: var(--error)
                }

                .grid-layout {
                    display: grid;
                    grid-template-columns: 1fr 400px;
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

                .form-group {
                    margin-bottom: 1.5rem
                }

                .form-label {
                    display: block;
                    margin-bottom: .5rem;
                    font-weight: 500;
                    color: var(--text-gray-light);
                    font-size: .95rem
                }

                .form-input,
                .form-select {
                    width: 100%;
                    padding: .875rem 1rem;
                    background: var(--bg-input);
                    border: 1px solid var(--border-dark);
                    border-radius: .75rem;
                    color: var(--text-white);
                    font-size: 1rem;
                    font-family: 'Inter', sans-serif;
                    transition: all .3s ease
                }

                .form-input:focus,
                .form-select:focus {
                    outline: none;
                    border-color: var(--accent-blue);
                    box-shadow: 0 0 0 3px rgba(59, 130, 246, .1)
                }

                .form-select {
                    cursor: pointer
                }

                .btn-group {
                    display: flex;
                    gap: 1rem;
                    margin-top: 2rem
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

                .calc-value {
                    font-size: 2.5rem;
                    font-weight: 800;
                    background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                    text-align: center;
                    margin-bottom: .5rem
                }

                .calc-label {
                    color: var(--text-gray);
                    font-size: .95rem;
                    text-align: center
                }

                .progress-bar {
                    width: 100%;
                    height: 8px;
                    background: var(--bg-input);
                    border-radius: 5px;
                    overflow: hidden;
                    margin: 1rem 0
                }

                .progress-fill {
                    height: 100%;
                    background: linear-gradient(90deg, var(--accent-blue), var(--success));
                    border-radius: 5px;
                    transition: width .3s ease
                }

                .info-card {
                    background: rgba(59, 130, 246, .05);
                    border: 1px solid rgba(59, 130, 246, .2)
                }

                .info-text {
                    color: var(--text-gray);
                    font-size: .95rem;
                    line-height: 1.6
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
                        <a href="<%=request.getContextPath()%>/client/dashboard" class="nav-item">
                            <i class="fas fa-home"></i><span>Tableau de bord</span>
                        </a>
                        <a href="<%=request.getContextPath()%>/client/nouveau_pret" class="nav-item active">
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
                        <h1 class="page-title">Nouvelle demande de prêt</h1>
                        <p class="page-subtitle">Complétez le formulaire pour soumettre votre demande de prêt</p>
                    </div>

                    <c:if test="${not empty sessionScope.errorMsg}">
                        <div class="alert alert-danger">
                            <i class="fas fa-exclamation-circle" style="font-size:1.5rem"></i>
                            <span>${sessionScope.errorMsg}</span>
                        </div>
                        <c:remove var="errorMsg" scope="session" />
                    </c:if>

                    <div class="grid-layout">
                        <div class="card">
                            <div class="card-header">
                                <h2 class="card-title">Informations du prêt</h2>
                            </div>
                            <div class="card-body">
                                <form method="post" action="<%=request.getContextPath()%>/client/nouveau_pret"
                                    id="formDemande">
                                    <div class="form-group">
                                        <label for="typePret" class="form-label">Type de prêt *</label>
                                        <select id="typePret" name="typePret" class="form-select" required>
                                            <option value="">-- Sélectionnez --</option>
                                            <option value="immobilier">Immobilier</option>
                                            <option value="automobile">Prêt automobile</option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label for="montant" class="form-label">Montant (€) *</label>
                                        <input type="number" id="montant" name="montant" class="form-input"
                                            placeholder="e.g., 50000" min="1000" max="5000000" required
                                            oninput="calculerMensualite()">
                                    </div>

                                    <div class="form-group">
                                        <label for="duree" class="form-label">Durée (mois) *</label>
                                        <input type="number" id="duree" name="duree" class="form-input"
                                            placeholder="e.g., 60" min="12" max="360" required
                                            oninput="calculerMensualite()">
                                    </div>

                                    <div class="form-group">
                                        <label for="taux" class="form-label">Taux d'intérêt annuel (%) *</label>
                                        <input type="number" id="taux" name="taux" class="form-input"
                                            placeholder="e.g., 3.5" min="0.1" max="20" step="0.1" required
                                            oninput="calculerMensualite()">
                                    </div>

                                    <div class="btn-group">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-paper-plane"></i> Soumettre la demande
                                        </button>
                                        <a href="<%=request.getContextPath()%>/client/dashboard"
                                            class="btn btn-secondary">
                                            <i class="fas fa-times"></i> Annuler
                                        </a>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <div>
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title" style="font-size:1rem">
                                        <i class="fas fa-calculator"></i> Mensualité estimée
                                    </h3>
                                </div>
                                <div class="card-body">
                                    <div class="calc-value" id="mensualiteValue">--</div>
                                    <div class="calc-label">€ / month</div>
                                </div>
                            </div>

                            <div class="card" id="carte40" style="display:none">
                                <div class="card-header">
                                    <h3 class="card-title" style="font-size:1rem">
                                        <i class="fas fa-chart-pie"></i> Debt Ratio
                                    </h3>
                                </div>
                                <div class="card-body">
                                    <div id="tauxValue" style="font-size:2rem;font-weight:700;text-align:center">--
                                    </div>
                                    <div class="progress-bar">
                                        <div id="tauxBar" class="progress-fill" style="width:0%"></div>
                                    </div>
                                    <p id="tauxMessage" class="info-text" style="font-size:.9rem;margin:0"></p>
                                </div>
                            </div>

                            <div class="card info-card">
                                <div class="card-body">
                                    <div style="display:flex;align-items:center;gap:.75rem;margin-bottom:.75rem">
                                        <i class="fas fa-info-circle"
                                            style="color:var(--accent-blue);font-size:1.25rem"></i>
                                        <strong>40% Rule</strong>
                                    </div>
                                    <p class="info-text" style="margin:0">
                                        Your monthly payment should not exceed 40% of your monthly income for optimal
                                        financial health.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>

            <script>
                function calculerMensualite() {
                    const montant = parseFloat(document.getElementById('montant').value);
                    const duree = parseInt(document.getElementById('duree').value);
                    const tauxAnnuel = parseFloat(document.getElementById('taux').value);

                    if (!montant || !duree || !tauxAnnuel) {
                        document.getElementById('mensualiteValue').textContent = '--';
                        document.getElementById('carte40').style.display = 'none';
                        return;
                    }

                    const r = (tauxAnnuel / 12) / 100;
                    const mensualite = (montant * r) / (1 - Math.pow(1 + r, -duree));

                    document.getElementById('mensualiteValue').textContent = Math.round(mensualite * 100) / 100;
                    document.getElementById('carte40').style.display = 'block';
                }
            </script>
        </body>

        </html>