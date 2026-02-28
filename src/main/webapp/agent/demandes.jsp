<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <fmt:setLocale value="fr_FR" />
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Toutes les demandes - NeuroBank Agent</title>

                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/table-scroll.css">

                <style>
                    /* ===== NEUROBANK MODERN - DEMANDES PAGE ===== */
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
                        width: 450px;
                        height: 450px;
                        background: var(--accent-purple);
                        top: -100px;
                        right: 10%;
                        animation-delay: 0s;
                    }

                    .orb-2 {
                        width: 400px;
                        height: 400px;
                        background: var(--accent-blue);
                        bottom: -100px;
                        left: -100px;
                        animation-delay: 10s;
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
                        position: relative;
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

                    /* Enhanced Filters */
                    .filters {
                        background: rgba(19, 24, 39, 0.6);
                        backdrop-filter: blur(10px);
                        border: 1px solid var(--border-dark);
                        border-radius: 1.25rem;
                        padding: 1.75rem;
                        margin-bottom: 2rem;
                        display: flex;
                        gap: 1.5rem;
                        flex-wrap: wrap;
                        align-items: flex-end;
                        animation: fadeInUp 0.6s ease 0.1s both;
                    }

                    .filter-group {
                        display: flex;
                        flex-direction: column;
                        gap: 0.625rem;
                        flex: 1;
                        min-width: 200px;
                    }

                    .filter-label {
                        font-size: 0.85rem;
                        color: var(--text-gray);
                        font-weight: 700;
                        text-transform: uppercase;
                        letter-spacing: 0.05em;
                    }

                    .filter-select {
                        padding: 0.875rem 1.25rem;
                        background: var(--bg-dark);
                        border: 1px solid var(--border-dark);
                        border-radius: 0.75rem;
                        color: var(--text-white);
                        font-family: inherit;
                        font-weight: 500;
                        transition: all 0.3s ease;
                        cursor: pointer;
                    }

                    .filter-select:focus {
                        outline: none;
                        border-color: var(--accent-blue);
                        box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
                    }

                    .filter-select:hover {
                        border-color: var(--accent-blue);
                    }

                    /* Enhanced Table Section */
                    .section {
                        background: rgba(19, 24, 39, 0.5);
                        backdrop-filter: blur(10px);
                        border: 1px solid var(--border-dark);
                        border-radius: 1.25rem;
                        padding: 2rem;
                        animation: fadeInUp 0.7s ease 0.2s both;
                    }

                    /* Table Scroll Container */
                    .table-scroll-container {
                        overflow-x: auto;
                        width: 100%;
                        border-radius: 0 0 1.25rem 1.25rem;
                    }

                    .table-scroll-container::-webkit-scrollbar {
                        height: 10px;
                    }

                    .table-scroll-container::-webkit-scrollbar-track {
                        background: rgba(255, 255, 255, 0.05);
                        border-radius: 5px;
                    }

                    .table-scroll-container::-webkit-scrollbar-thumb {
                        background: linear-gradient(90deg, #3b82f6, #8b5cf6);
                        border-radius: 5px;
                    }

                    .table-scroll-container::-webkit-scrollbar-thumb:hover {
                        background: linear-gradient(90deg, #2563eb, #7c3aed);
                    }

                    .requests-table {
                        width: 100%;
                        border-collapse: collapse;
                        white-space: nowrap;
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
                        padding: 1rem 1.25rem;
                        border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                        color: var(--text-light);
                        vertical-align: middle;
                    }

                    /* Professional Buttons */
                    .action-buttons {
                        display: flex;
                        flex-direction: row;
                        /* FORCE HORIZONTAL */
                        flex-wrap: nowrap;
                        gap: 0.5rem;
                        justify-content: center;
                        align-items: center;
                        width: 100%;
                    }

                    .btn {
                        padding: 0.5rem 0.8rem;
                        /* Slightly smaller horizontal padding */
                        border-radius: 0.5rem;
                        font-weight: 500;
                        font-size: 0.8rem;
                        /* Slightly smaller font to fit */
                        cursor: pointer;
                        transition: all 0.2s ease;
                        border: none;
                        display: inline-flex;
                        align-items: center;
                        gap: 0.3rem;
                        color: white !important;
                        text-decoration: none;
                        white-space: nowrap;
                        /* Prevent text wrapping */
                        min-width: 90px;
                        justify-content: center;
                    }

                    .btn:hover {
                        transform: translateY(-1px);
                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
                    }

                    .btn i {
                        font-size: 0.9em;
                    }

                    .btn-ia {
                        background: linear-gradient(135deg, #6366f1, #8b5cf6);
                        box-shadow: 0 2px 8px rgba(99, 102, 241, 0.3);
                    }

                    .btn-ia:hover {
                        box-shadow: 0 4px 15px rgba(99, 102, 241, 0.4);
                        filter: brightness(1.1);
                    }

                    .btn-approve {
                        background: rgba(16, 185, 129, 0.15);
                        color: #10b981 !important;
                        border: 1px solid rgba(16, 185, 129, 0.2);
                    }

                    .btn-approve:hover {
                        background: rgba(16, 185, 129, 0.25);
                        border-color: rgba(16, 185, 129, 0.4);
                    }

                    .btn-reject {
                        background: rgba(239, 68, 68, 0.15);
                        color: #ef4444 !important;
                        border: 1px solid rgba(239, 68, 68, 0.2);
                    }

                    .btn-reject:hover {
                        background: rgba(239, 68, 68, 0.25);
                        border-color: rgba(239, 68, 68, 0.4);
                    }

                    .btn-details {
                        background: rgba(59, 130, 246, 0.15);
                        color: #3b82f6 !important;
                        border: 1px solid rgba(59, 130, 246, 0.2);
                    }

                    .btn-details:hover {
                        background: rgba(59, 130, 246, 0.25);
                        border-color: rgba(59, 130, 246, 0.4);
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

                    .badge:hover {
                        transform: scale(1.05);
                    }

                    /* AI Score Badges */
                    .ai-badge {
                        padding: 0.5rem 1rem;
                        border-radius: 0.625rem;
                        font-size: 0.85rem;
                        font-weight: 700;
                        display: inline-flex;
                        align-items: center;
                        gap: 0.5rem;
                        transition: all 0.3s ease;
                    }

                    .ai-low {
                        background: rgba(16, 185, 129, 0.15);
                        color: var(--success);
                        border: 1px solid rgba(16, 185, 129, 0.4);
                        box-shadow: 0 0 15px rgba(16, 185, 129, 0.2);
                    }

                    .ai-medium {
                        background: rgba(251, 191, 36, 0.15);
                        color: var(--warning);
                        border: 1px solid rgba(251, 191, 36, 0.4);
                        box-shadow: 0 0 15px rgba(251, 191, 36, 0.2);
                    }

                    .ai-high {
                        background: rgba(239, 68, 68, 0.15);
                        color: var(--error);
                        border: 1px solid rgba(239, 68, 68, 0.4);
                        box-shadow: 0 0 15px rgba(239, 68, 68, 0.2);
                    }

                    .ai-pending {
                        background: rgba(100, 116, 139, 0.15);
                        color: var(--text-gray);
                        border: 1px solid rgba(100, 116, 139, 0.3);
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

                    /* Action buttons container */
                    .action-buttons {
                        display: flex;
                        gap: 0.5rem;
                        flex-wrap: wrap;
                        justify-content: center;
                    }

                    /* Bouton Analyser IA */
                    .btn-ia {
                        background: linear-gradient(135deg, #8b5cf6 0%, #6d28d9 100%);
                        color: white;
                        border: none;
                        font-size: 0.85rem;
                        padding: 0.5rem 1rem;
                        border-radius: 0.75rem;
                        cursor: pointer;
                        transition: all 0.3s ease;
                        font-weight: 600;
                    }

                    .btn-ia:hover {
                        background: linear-gradient(135deg, #7c3aed 0%, #5b21b6 100%);
                        transform: translateY(-2px);
                        box-shadow: 0 8px 20px rgba(139, 92, 246, 0.5);
                    }

                    .btn-ia:disabled {
                        opacity: 0.5;
                        cursor: not-allowed;
                    }

                    /* Bouton Valider */
                    .btn-approve {
                        background: rgba(16, 185, 129, 0.1);
                        color: var(--success);
                        border: 1px solid rgba(16, 185, 129, 0.3);
                        font-size: 0.85rem;
                        padding: 0.5rem 1rem;
                        border-radius: 0.75rem;
                        cursor: pointer;
                        transition: all 0.3s ease;
                        font-weight: 600;
                    }

                    .btn-approve:hover {
                        background: var(--success);
                        color: white;
                        transform: translateY(-2px);
                        box-shadow: 0 8px 20px rgba(16, 185, 129, 0.4);
                    }

                    /* Bouton Refuser */
                    .btn-reject {
                        background: rgba(239, 68, 68, 0.1);
                        color: var(--error);
                        border: 1px solid rgba(239, 68, 68, 0.3);
                        font-size: 0.85rem;
                        padding: 0.5rem 1rem;
                        border-radius: 0.75rem;
                        cursor: pointer;
                        transition: all 0.3s ease;
                        font-weight: 600;
                    }

                    .btn-reject:hover {
                        background: var(--error);
                        color: white;
                        transform: translateY(-2px);
                        box-shadow: 0 8px 20px rgba(239, 68, 68, 0.4);
                    }

                    /* Bouton Détails */
                    .btn-details {
                        background: rgba(59, 130, 246, 0.1);
                        color: var(--accent-blue);
                        border: 1px solid rgba(59, 130, 246, 0.3);
                        font-size: 0.85rem;
                        text-decoration: none;
                        padding: 0.5rem 1rem;
                        border-radius: 0.75rem;
                        display: inline-flex;
                        align-items: center;
                        gap: 0.5rem;
                        transition: all 0.3s ease;
                        font-weight: 600;
                    }

                    .btn-details:hover {
                        background: var(--accent-blue);
                        color: white;
                        transform: translateY(-2px);
                        box-shadow: 0 8px 20px rgba(59, 130, 246, 0.4);
                    }

                    /* Pagination Styles */
                    .pagination {
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                        gap: 1rem;
                        margin-top: 2rem;
                        padding: 1.5rem 0;
                        border-top: 1px solid var(--border-dark);
                    }

                    .pagination-info {
                        color: var(--text-gray);
                        font-size: 0.9rem;
                        text-align: center;
                    }

                    .pagination-info strong {
                        color: var(--accent-blue);
                        font-weight: 700;
                    }

                    .pagination-buttons {
                        display: flex;
                        gap: 0.5rem;
                    }

                    .pagination-btn {
                        min-width: 40px;
                        height: 40px;
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        background: rgba(255, 255, 255, 0.05);
                        border: 1px solid rgba(255, 255, 255, 0.1);
                        border-radius: 0.5rem;
                        color: var(--text-white);
                        text-decoration: none;
                        font-weight: 600;
                        transition: all 0.3s ease;
                    }

                    .pagination-btn:hover {
                        background: var(--accent-blue);
                        border-color: var(--accent-blue);
                        transform: translateY(-2px);
                        box-shadow: 0 4px 12px rgba(59, 130, 246, 0.4);
                    }

                    .pagination-btn.active {
                        background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
                        border-color: var(--accent-purple);
                        box-shadow: 0 4px 12px rgba(139, 92, 246, 0.4);
                        pointer-events: none;
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

                        .filters {
                            flex-direction: column;
                        }

                        .filter-group {
                            width: 100%;
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
                            <h1 class="page-title">Toutes les demandes de prêt</h1>
                            <p class="page-subtitle">Gérez et examinez toutes les demandes de prêt</p>
                        </div>

                        <!-- Filters -->
                        <div class="filters">
                            <div class="filter-group">
                                <label class="filter-label"><i class="fas fa-filter"></i> Statut</label>
                                <select class="filter-select"
                                    onchange="window.location.href='${pageContext.request.contextPath}/agent/demandes?statut=' + this.value">
                                    <option value="">Tous</option>
                                    <option value="EN_ATTENTE" ${param.statut=='EN_ATTENTE' ? 'selected' : '' }>En
                                        attente</option>
                                    <option value="VALIDE" ${param.statut=='VALIDE' ? 'selected' : '' }>Validé
                                    </option>
                                    <option value="REJETE" ${param.statut=='REJETE' ? 'selected' : '' }>Rejeté
                                    </option>
                                </select>
                            </div>

                            <div class="filter-group">
                                <label class="filter-label"><i class="fas fa-tag"></i> Type</label>
                                <select class="filter-select"
                                    onchange="window.location.href='${pageContext.request.contextPath}/agent/demandes?type=' + this.value">
                                    <option value="">Tous</option>
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
                                        <th>ID</th>
                                        <th>Date</th>
                                        <th>Client</th>
                                        <th>Risque</th>
                                        <th>Statut</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${demandes}" var="d">
                                        <tr>
                                            <td><strong>#${d.idDemande}</strong></td>
                                            <td>
                                                <fmt:formatDate value="${d.dateCreation}" pattern="dd/MM/yyyy" />
                                            </td>
                                            <td>Client #${d.idClient}</td>
                                            <td>
                                                <!-- Affichage simplifié du risque -->
                                                <c:set var="pred" value="${predictions[d.idDemande]}" />
                                                <c:choose>
                                                    <c:when test="${pred != null && pred.scoreRisque != null}">
                                                        <c:choose>
                                                            <c:when test="${pred.scoreRisque < 60}">
                                                                <span class="ai-badge ai-low">
                                                                    <i class="fas fa-check-shield"></i> Faible
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="ai-badge ai-high">
                                                                    <i class="fas fa-exclamation-triangle"></i> Élevé
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="ai-badge ai-pending">
                                                            <i class="fas fa-hourglass-half"></i> En attente
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${d.statut=='EN_ATTENTE'}">
                                                        <span class="badge badge-pending">
                                                            <i class="fas fa-clock"></i> En attente
                                                        </span>
                                                    </c:when>
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
                                                    <c:otherwise>
                                                        <span class="badge badge-pending">${d.statut}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <!-- Bouton Analyser IA (si pas encore analysé) -->
                                                    <c:if test="${pred == null}">
                                                        <button class="btn btn-ia" onclick="analyserIA(${d.idDemande})"
                                                            id="btn-analyse-${d.idDemande}" title="Analyser avec IA">
                                                            <i class="fas fa-robot"></i> Analyser IA
                                                        </button>
                                                    </c:if>

                                                    <!-- Boutons Valider/Refuser (si EN_ATTENTE) -->
                                                    <c:if test="${d.statut == 'EN_ATTENTE'}">
                                                        <button class="btn btn-approve"
                                                            onclick="validerDemande(${d.idDemande})"
                                                            title="Valider la demande">
                                                            <i class="fas fa-check"></i> Valider
                                                        </button>
                                                        <button class="btn btn-reject"
                                                            onclick="refuserDemande(${d.idDemande})"
                                                            title="Refuser la demande">
                                                            <i class="fas fa-times"></i> Refuser
                                                        </button>
                                                    </c:if>

                                                    <!-- Bouton Détails (toujours visible) -->
                                                    <a href="${pageContext.request.contextPath}/agent/details?id=${d.idDemande}"
                                                        class="btn btn-details" title="Voir les détails">
                                                        <i class="fas fa-info-circle"></i> Détails
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty demandes}">
                                        <tr>
                                            <td colspan="6">
                                                <div class="empty-state">
                                                    <i class="fas fa-inbox"></i>
                                                    <p>Aucune demande trouvée</p>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>


                        <!-- Pagination Controls -->
                        <div class="pagination">
                            <div class="pagination-info">
                                Affichage <strong>${(currentPage - 1) * 10 + 1}</strong> à <strong>${(currentPage -
                                    1) * 10 + demandes.size()}</strong> sur <strong>${totalItems}</strong> demandes
                            </div>

                            <div class="pagination-buttons">
                                <c:if test="${currentPage > 1}">
                                    <a href="?page=1<c:if test='${filtreStatut != null}'>&statut=${filtreStatut}</c:if><c:if test='${filtreType != null}'>&type=${filtreType}</c:if>"
                                        class="pagination-btn" title="Première page">
                                        <i class="fas fa-angle-double-left"></i>
                                    </a>
                                </c:if>

                                <c:if test="${currentPage > 1}">
                                    <a href="?page=${currentPage - 1}<c:if test='${filtreStatut != null}'>&statut=${filtreStatut}</c:if><c:if test='${filtreType != null}'>&type=${filtreType}</c:if>"
                                        class="pagination-btn" title="Page précédente">
                                        <i class="fas fa-angle-left"></i>
                                    </a>
                                </c:if>

                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <c:if test="${i >= currentPage - 2 && i <= currentPage + 2}">
                                        <a href="?page=${i}<c:if test='${filtreStatut != null}'>&statut=${filtreStatut}</c:if><c:if test='${filtreType != null}'>&type=${filtreType}</c:if>"
                                            class="pagination-btn ${i == currentPage ? 'active' : ''}">
                                            ${i}
                                        </a>
                                    </c:if>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <a href="?page=${currentPage + 1}<c:if test='${filtreStatut != null}'>&statut=${filtreStatut}</c:if><c:if test='${filtreType != null}'>&type=${filtreType}</c:if>"
                                        class="pagination-btn" title="Page suivante">
                                        <i class="fas fa-angle-right"></i>
                                    </a>
                                </c:if>

                                <c:if test="${currentPage < totalPages}">
                                    <a href="?page=${totalPages}<c:if test='${filtreStatut != null}'>&statut=${filtreStatut}</c:if><c:if test='${filtreType != null}'>&type=${filtreType}</c:if>"
                                        class="pagination-btn" title="Dernière page">
                                        <i class="fas fa-angle-double-right"></i>
                                    </a>
                                </c:if>
                            </div>
                        </div>
                </div>
                </main>
                </div>
                <script>
                    // Fonction pour analyser une demande avec l'IA
                    function analyserIA(idDemande) {
                        const btn = document.getElementById('btn-analyse-' + idDemande);
                        const originalContent = btn.innerHTML;

                        // État de chargement
                        btn.disabled = true;
                        btn.innerHTML = '<i class="fas fa-circle-notch fa-spin"></i> Analyse...';

                        fetch('${pageContext.request.contextPath}/agent/analyser-demande?idDemande=' + idDemande, {
                            method: 'POST'
                        })
                            .then(response => response.json())
                            .then(data => {
                                if (data.success) {
                                    location.reload();
                                } else {
                                    alert('Erreur: ' + (data.error || 'Erreur inconnue'));
                                    btn.disabled = false;
                                    btn.innerHTML = originalContent;
                                }
                            })
                            .catch(error => {
                                console.error('Erreur:', error);
                                alert('Erreur de communication avec le serveur (IA)');
                                btn.disabled = false;
                                btn.innerHTML = originalContent;
                            });
                    }

                    // Fonction pour valider une demande
                    function validerDemande(idDemande) {
                        if (!confirm('Êtes-vous sûr de vouloir VALIDER cette demande ? Elle sera transférée vers l\'historique.')) {
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
                                    location.reload();
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
                        if (!confirm('Êtes-vous sûr de vouloir REFUSER cette demande ? Cette action est irréversible.')) {
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
                                    location.reload();
                                } else {
                                    alert('Erreur: ' + (data.error || 'Impossible de refuser'));
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