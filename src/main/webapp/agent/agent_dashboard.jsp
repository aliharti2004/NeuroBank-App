<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <fmt:setLocale value="fr_FR" />
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Tableau de bord Agent - NeuroBank</title>

                <!-- Icons & Fonts -->
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap"
                    rel="stylesheet">
                <!-- Chart.js -->
                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

                <style>
                    /* ===== NEUROBANK MODERN & INTERACTIVE - AGENT DASHBOARD ===== */
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
                        background: var(--accent-blue);
                        top: -100px;
                        right: -100px;
                        animation-delay: 0s;
                    }

                    .orb-2 {
                        width: 400px;
                        height: 400px;
                        background: var(--accent-purple);
                        bottom: -100px;
                        left: 20%;
                        animation-delay: 7s;
                    }

                    .orb-3 {
                        width: 350px;
                        height: 350px;
                        background: var(--accent-blue);
                        top: 50%;
                        left: -100px;
                        animation-delay: 14s;
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

                    /* Fade-in animations */
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

                    @keyframes fadeInScale {
                        from {
                            opacity: 0;
                            transform: scale(0.95);
                        }

                        to {
                            opacity: 1;
                            transform: scale(1);
                        }
                    }

                    /* Layout */
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
                        animation: fadeInScale 0.5s ease;
                    }

                    .sidebar-header {
                        margin-bottom: 3rem;
                        padding-bottom: 1.5rem;
                        border-bottom: 1px solid var(--border-dark);
                    }

                    .logo {
                        display: flex;
                        align-items: center;
                        gap: 0.75rem;
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
                        position: relative;
                        overflow: hidden;
                    }

                    .nav-item::before {
                        content: '';
                        position: absolute;
                        left: 0;
                        top: 0;
                        height: 100%;
                        width: 3px;
                        background: var(--accent-blue);
                        transform: scaleY(0);
                        transition: transform 0.3s ease;
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

                    .nav-item.active::before {
                        transform: scaleY(1);
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
                        animation: fadeInUp 0.6s ease;
                    }

                    /* Top Bar */
                    .top-bar {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 2.5rem;
                        padding-bottom: 1.5rem;
                        border-bottom: 1px solid var(--border-dark);
                        animation: fadeInUp 0.5s ease;
                    }

                    .page-title {
                        font-size: 2.25rem;
                        font-weight: 900;
                        background: linear-gradient(135deg, var(--text-white), var(--accent-blue));
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                        letter-spacing: -0.02em;
                    }

                    .user-info {
                        display: flex;
                        align-items: center;
                        gap: 1rem;
                        padding: 0.875rem 1.75rem;
                        background: rgba(19, 24, 39, 0.6);
                        backdrop-filter: blur(10px);
                        border-radius: 0.75rem;
                        border: 1px solid var(--border-dark);
                        transition: all 0.3s ease;
                    }

                    .user-info:hover {
                        border-color: var(--accent-blue);
                        transform: translateY(-2px);
                        box-shadow: 0 10px 30px rgba(59, 130, 246, 0.2);
                    }

                    .user-info i {
                        color: var(--accent-blue);
                        font-size: 1.35rem;
                    }

                    /* Stats Grid with enhanced effects */
                    .stats-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
                        gap: 1.5rem;
                        margin-bottom: 2.5rem;
                    }

                    .stat-card {
                        background: rgba(19, 24, 39, 0.5);
                        backdrop-filter: blur(10px);
                        border: 1px solid var(--border-dark);
                        border-radius: 1.25rem;
                        padding: 1.75rem;
                        display: flex;
                        align-items: center;
                        gap: 1.5rem;
                        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                        position: relative;
                        overflow: hidden;
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

                    .stat-card:nth-child(4) {
                        animation-delay: 0.4s;
                    }

                    .stat-card::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        height: 4px;
                        background: linear-gradient(90deg, var(--accent-blue), var(--accent-purple));
                        transform: scaleX(0);
                        transition: transform 0.4s ease;
                    }

                    .stat-card::after {
                        content: '';
                        position: absolute;
                        inset: 0;
                        background: radial-gradient(circle at 50% 50%, rgba(59, 130, 246, 0.1), transparent 60%);
                        opacity: 0;
                        transition: opacity 0.4s ease;
                    }

                    .stat-card:hover {
                        transform: translateY(-8px) scale(1.02);
                        border-color: var(--accent-blue);
                        box-shadow: 0 20px 40px rgba(59, 130, 246, 0.25);
                    }

                    .stat-card:hover::before {
                        transform: scaleX(1);
                    }

                    .stat-card:hover::after {
                        opacity: 1;
                    }

                    .stat-icon {
                        width: 60px;
                        height: 60px;
                        border-radius: 1rem;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 1.5rem;
                        position: relative;
                        z-index: 1;
                        transition: transform 0.4s ease;
                    }

                    .stat-card:hover .stat-icon {
                        transform: rotateY(360deg);
                    }

                    .stat-icon.pending {
                        background: linear-gradient(135deg, rgba(251, 191, 36, 0.15), rgba(245, 158, 11, 0.15));
                        color: var(--warning);
                        box-shadow: 0 8px 20px rgba(251, 191, 36, 0.2);
                    }

                    .stat-icon.money-pending {
                        background: linear-gradient(135deg, rgba(59, 130, 246, 0.15), rgba(37, 99, 235, 0.15));
                        color: var(--accent-blue);
                        box-shadow: 0 8px 20px rgba(59, 130, 246, 0.2);
                    }

                    .stat-icon.completed {
                        background: linear-gradient(135deg, rgba(16, 185, 129, 0.15), rgba(5, 150, 105, 0.15));
                        color: var(--success);
                        box-shadow: 0 8px 20px rgba(16, 185, 129, 0.2);
                    }

                    .stat-icon.rate {
                        background: linear-gradient(135deg, rgba(139, 92, 246, 0.15), rgba(124, 58, 237, 0.15));
                        color: var(--accent-purple);
                        box-shadow: 0 8px 20px rgba(139, 92, 246, 0.2);
                    }

                    .stat-info {
                        flex: 1;
                        position: relative;
                        z-index: 1;
                    }

                    .stat-info h3 {
                        font-size: 0.85rem;
                        color: var(--text-gray);
                        font-weight: 600;
                        margin-bottom: 0.5rem;
                        text-transform: uppercase;
                        letter-spacing: 0.05em;
                    }

                    .stat-value {
                        font-size: 1.75rem;
                        font-weight: 900;
                        background: linear-gradient(135deg, var(--text-white), var(--accent-blue));
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                    }

                    .stat-subtext {
                        font-size: 0.8rem;
                        color: var(--text-gray-light);
                        margin-top: 0.25rem;
                    }

                    /* Charts Section */
                    .charts-container {
                        display: grid;
                        grid-template-columns: 2fr 1fr;
                        gap: 1.5rem;
                        margin-bottom: 2rem;
                    }

                    .chart-card {
                        background: rgba(19, 24, 39, 0.5);
                        backdrop-filter: blur(10px);
                        border: 1px solid var(--border-dark);
                        border-radius: 1.25rem;
                        padding: 2rem;
                        animation: fadeInUp 0.7s ease 0.4s both;
                        height: 400px;
                        display: flex;
                        flex-direction: column;
                    }

                    .chart-header {
                        margin-bottom: 1.5rem;
                    }

                    .chart-header h2 {
                        font-size: 1.25rem;
                        font-weight: 700;
                        color: var(--text-white);
                    }

                    .chart-canvas-container {
                        flex: 1;
                        position: relative;
                        width: 100%;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                    }

                    /* Responsive */
                    @media (max-width: 1024px) {
                        .charts-container {
                            grid-template-columns: 1fr;
                        }
                    }

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

                        .top-bar {
                            flex-direction: column;
                            gap: 1rem;
                            align-items: flex-start;
                        }
                    }
                </style>
            </head>

            <body>
                <!-- Animated Background -->
                <div class="animated-bg">
                    <div class="gradient-orb orb-1"></div>
                    <div class="gradient-orb orb-2"></div>
                    <div class="gradient-orb orb-3"></div>
                </div>

                <div class="dashboard-container">
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

                        <nav class="nav-links">
                            <a href="${pageContext.request.contextPath}/agent/dashboard" class="nav-item active">
                                <i class="fas fa-chart-line"></i>
                                Tableau de bord
                            </a>
                            <a href="${pageContext.request.contextPath}/agent/demandes" class="nav-item">
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
                        <!-- Top Bar -->
                        <div class="top-bar">
                            <h1 class="page-title">Tableau de bord</h1>
                            <div class="user-info">
                                <span>Bonjour, <strong>${sessionScope.user.prenom}
                                        ${sessionScope.user.nom}</strong></span>
                                <i class="fas fa-user-tie"></i>
                            </div>
                        </div>

                        <!-- Stats Grid -->
                        <div class="stats-grid">
                            <!-- En attente -->
                            <div class="stat-card">
                                <div class="stat-icon pending">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <div class="stat-info">
                                    <h3>En attente</h3>
                                    <p class="stat-value">${statEnAttente}</p>
                                    <p class="stat-subtext">Demandes à traiter</p>
                                </div>
                            </div>

                            <!-- Montant en attente -->
                            <div class="stat-card">
                                <div class="stat-icon money-pending">
                                    <i class="fas fa-coins"></i>
                                </div>
                                <div class="stat-info">
                                    <h3>Volume en attente</h3>
                                    <p class="stat-value">
                                        <fmt:formatNumber value="${montantEnAttente}" type="number"
                                            maxFractionDigits="0" />€
                                    </p>
                                    <p class="stat-subtext">Potentiel commercial</p>
                                </div>
                            </div>

                            <!-- Montant Accordé -->
                            <div class="stat-card">
                                <div class="stat-icon completed">
                                    <i class="fas fa-check-circle"></i>
                                </div>
                                <div class="stat-info">
                                    <h3>Volume Accordé</h3>
                                    <p class="stat-value">
                                        <fmt:formatNumber value="${montantAccorde}" type="number"
                                            maxFractionDigits="0" />€
                                    </p>
                                    <p class="stat-subtext">Total validé</p>
                                </div>
                            </div>

                            <!-- Taux d'approbation -->
                            <div class="stat-card">
                                <div class="stat-icon rate">
                                    <i class="fas fa-percentage"></i>
                                </div>
                                <div class="stat-info">
                                    <h3>Taux d'approbation</h3>
                                    <p class="stat-value">${statTauxApprobation}%</p>
                                    <p class="stat-subtext">Sur ${statTraitees} dossiers</p>
                                </div>
                            </div>
                        </div>

                        <!-- Charts Section -->
                        <div class="charts-container">
                            <!-- Status Distribution Chart -->
                            <div class="chart-card">
                                <div class="chart-header">
                                    <h2><i class="fas fa-chart-pie"></i> Répartition des dossiers</h2>
                                </div>
                                <div class="chart-canvas-container">
                                    <canvas id="statusChart"></canvas>
                                </div>
                            </div>

                            <!-- Loan Type Distribution -->
                            <div class="chart-card">
                                <div class="chart-header">
                                    <h2><i class="fas fa-car-building"></i> Types de prêts</h2>
                                </div>
                                <div class="chart-canvas-container">
                                    <canvas id="typeChart"></canvas>
                                </div>
                            </div>
                        </div>

                    </main>
                </div>

                <script>
                    // Configuration commune pour Chart.js
                    Chart.defaults.color = '#94a3b8';
                    Chart.defaults.borderColor = '#1e293b';
                    Chart.defaults.font.family = "'Inter', sans-serif";

                    // Données injectées depuis la JSP
                    const statValidees = ${ statValidees };
                    const statRejetees = ${ statRejetees };
                    const statEnAttente = ${ statEnAttente };

                    const countImmo = ${ countImmo };
                    const countAuto = ${ countAuto };

                    // Graphique Répartition Statut (Doughnut)
                    const ctxStatus = document.getElementById('statusChart').getContext('2d');
                    new Chart(ctxStatus, {
                        type: 'doughnut',
                        data: {
                            labels: ['Validés', 'Rejetés', 'En attente'],
                            datasets: [{
                                data: [statValidees, statRejetees, statEnAttente],
                                backgroundColor: [
                                    '#10b981', // Success Green
                                    '#ef4444', // Error Red
                                    '#f59e0b'  // Warning Orange
                                ],
                                borderWidth: 0,
                                hoverOffset: 10
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    position: 'bottom',
                                    labels: {
                                        padding: 20,
                                        usePointStyle: true,
                                        pointStyle: 'circle'
                                    }
                                }
                            },
                            cutout: '70%'
                        }
                    });

                    // Graphique Types de Prêts (Bar)
                    const ctxType = document.getElementById('typeChart').getContext('2d');
                    new Chart(ctxType, {
                        type: 'bar',
                        data: {
                            labels: ['Immobilier', 'Automobile'],
                            datasets: [{
                                label: 'Nombre de demandes',
                                data: [countImmo, countAuto],
                                backgroundColor: [
                                    '#3b82f6', // Blue
                                    '#8b5cf6'  // Purple
                                ],
                                borderRadius: 8,
                                barThickness: 40
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    display: false
                                }
                            },
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    grid: {
                                        display: true,
                                        drawBorder: false
                                    }
                                },
                                x: {
                                    grid: {
                                        display: false
                                    }
                                }
                            }
                        }
                    });
                </script>
            </body>

            </html>