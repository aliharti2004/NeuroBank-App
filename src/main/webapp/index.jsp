<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="fr">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description"
            content="NeuroBank - AI-Powered Loan Decision Platform. Make smarter lending decisions in 3 minutes with explainable AI.">
        <title>NeuroBank - Plateforme de décision de prêt par IA</title>

        <!-- Icons -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap"
            rel="stylesheet">

        <style>
            /* ===== NEUROBANK - INTERACTIVE & MODERN ===== */

            :root {
                --bg-dark: #0a0e1a;
                --bg-card: #131827;
                --bg-card-hover: #1a1f35;
                --accent-blue: #3b82f6;
                --accent-blue-dark: #2563eb;
                --accent-blue-light: #60a5fa;
                --accent-purple: #8b5cf6;
                --text-white: #ffffff;
                --text-gray: #94a3b8;
                --text-gray-light: #cbd5e1;
                --border-dark: #1e293b;
                --success: #10b981;
            }

            *,
            *::before,
            *::after {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            html {
                font-size: 16px;
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
                opacity: 0.3;
                animation: float 20s ease-in-out infinite;
            }

            .orb-1 {
                width: 500px;
                height: 500px;
                background: var(--accent-blue);
                top: -250px;
                right: -250px;
                animation-delay: 0s;
            }

            .orb-2 {
                width: 400px;
                height: 400px;
                background: var(--accent-purple);
                bottom: -200px;
                left: -200px;
                animation-delay: 5s;
            }

            .orb-3 {
                width: 300px;
                height: 300px;
                background: var(--accent-blue-light);
                top: 50%;
                left: 50%;
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

            /* Scroll Animations */
            .fade-in {
                opacity: 0;
                transform: translateY(30px);
                transition: opacity 0.6s ease, transform 0.6s ease;
            }

            .fade-in.visible {
                opacity: 1;
                transform: translateY(0);
            }

            .slide-left {
                opacity: 0;
                transform: translateX(-50px);
                transition: opacity 0.6s ease, transform 0.6s ease;
            }

            .slide-left.visible {
                opacity: 1;
                transform: translateX(0);
            }

            .slide-right {
                opacity: 0;
                transform: translateX(50px);
                transition: opacity 0.6s ease, transform 0.6s ease;
            }

            .slide-right.visible {
                opacity: 1;
                transform: translateX(0);
            }

            /* Navigation */
            .nav {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1000;
                background: rgba(10, 14, 26, 0.8);
                backdrop-filter: blur(20px);
                border-bottom: 1px solid var(--border-dark);
                transition: all 0.3s ease;
            }

            .nav.scrolled {
                background: rgba(10, 14, 26, 0.95);
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            }

            .nav-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 1.25rem 2rem;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .nav-logo {
                display: flex;
                align-items: center;
                gap: 0.75rem;
                font-size: 1.5rem;
                font-weight: 800;
                color: var(--text-white);
                cursor: pointer;
                transition: transform 0.3s ease;
            }

            .nav-logo:hover {
                transform: scale(1.05);
            }

            .nav-logo i {
                font-size: 2rem;
                background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                animation: pulse-icon 2s ease-in-out infinite;
            }

            @keyframes pulse-icon {

                0%,
                100% {
                    transform: scale(1);
                }

                50% {
                    transform: scale(1.1);
                }
            }

            .nav-links {
                display: flex;
                align-items: center;
                gap: 2.5rem;
            }

            .nav-link {
                color: var(--text-gray);
                font-weight: 500;
                transition: all 0.3s ease;
                font-size: 0.95rem;
                position: relative;
            }

            .nav-link::after {
                content: '';
                position: absolute;
                bottom: -5px;
                left: 0;
                width: 0;
                height: 2px;
                background: var(--accent-blue);
                transition: width 0.3s ease;
            }

            .nav-link:hover {
                color: var(--text-white);
            }

            .nav-link:hover::after {
                width: 100%;
            }

            .nav-actions {
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            /* Buttons with enhanced effects */
            .btn {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                padding: 0.75rem 1.75rem;
                font-family: 'Inter', sans-serif;
                font-size: 0.95rem;
                font-weight: 600;
                border-radius: 0.5rem;
                cursor: pointer;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                text-decoration: none;
                border: none;
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

            .btn-primary {
                background: linear-gradient(135deg, var(--accent-blue), var(--accent-blue-dark));
                color: white;
                box-shadow: 0 4px 15px rgba(59, 130, 246, 0.4);
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(59, 130, 246, 0.5);
            }

            .btn-outline {
                background: transparent;
                color: var(--text-white);
                border: 2px solid var(--accent-blue);
            }

            .btn-outline:hover {
                background: rgba(59, 130, 246, 0.1);
                transform: translateY(-2px);
            }

            .btn-ghost {
                background: transparent;
                color: var(--text-gray);
            }

            .btn-ghost:hover {
                color: var(--text-white);
            }

            /* Hero Section */
            .hero {
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                text-align: center;
                padding: 8rem 2rem 4rem;
                position: relative;
                z-index: 1;
            }

            .hero-content {
                max-width: 900px;
                position: relative;
            }

            .hero-badge {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                padding: 0.5rem 1.25rem;
                background: var(--bg-card);
                border: 1px solid var(--border-dark);
                border-radius: 2rem;
                font-size: 0.875rem;
                color: var(--text-gray-light);
                margin-bottom: 2rem;
                animation: bounce-in 0.6s ease;
            }

            @keyframes bounce-in {
                0% {
                    opacity: 0;
                    transform: scale(0.8) translateY(20px);
                }

                100% {
                    opacity: 1;
                    transform: scale(1) translateY(0);
                }
            }

            .hero-title {
                font-size: 4.5rem;
                font-weight: 900;
                line-height: 1.1;
                margin-bottom: 1.5rem;
                letter-spacing: -0.02em;
                animation: fade-in-up 0.8s ease 0.2s both;
            }

            @keyframes fade-in-up {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .hero-title .highlight {
                background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                animation: gradient-shift 3s ease infinite;
                background-size: 200% 200%;
            }

            @keyframes gradient-shift {

                0%,
                100% {
                    background-position: 0% 50%;
                }

                50% {
                    background-position: 100% 50%;
                }
            }

            .hero-subtitle {
                font-size: 1.35rem;
                color: var(--text-gray-light);
                margin-bottom: 3rem;
                line-height: 1.6;
                max-width: 700px;
                margin-left: auto;
                margin-right: auto;
                animation: fade-in-up 0.8s ease 0.4s both;
            }

            .hero-buttons {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 1rem;
                margin-bottom: 4rem;
                animation: fade-in-up 0.8s ease 0.6s both;
            }

            .hero-stats {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 3rem;
                max-width: 700px;
                margin: 0 auto;
                padding-top: 3rem;
                border-top: 1px solid var(--border-dark);
            }

            .stat {
                text-align: center;
                cursor: pointer;
                transition: transform 0.3s ease;
            }

            .stat:hover {
                transform: scale(1.1);
            }

            .stat-value {
                font-size: 3rem;
                font-weight: 800;
                background: linear-gradient(135deg, var(--text-white), var(--text-gray-light));
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                margin-bottom: 0.5rem;
            }

            .stat-label {
                font-size: 0.95rem;
                color: var(--text-gray);
            }

            /* Section */
            .section {
                padding: 6rem 2rem;
                max-width: 1200px;
                margin: 0 auto;
                position: relative;
                z-index: 1;
            }

            .section-header {
                text-align: center;
                max-width: 700px;
                margin: 0 auto 4rem;
            }

            .section-badge {
                display: inline-block;
                padding: 0.5rem 1.25rem;
                background: rgba(59, 130, 246, 0.1);
                color: var(--accent-blue);
                border-radius: 2rem;
                font-size: 0.875rem;
                font-weight: 600;
                margin-bottom: 1rem;
            }

            .section-title {
                font-size: 3rem;
                font-weight: 800;
                margin-bottom: 1.25rem;
                letter-spacing: -0.02em;
            }

            .section-subtitle {
                font-size: 1.15rem;
                color: var(--text-gray-light);
            }

            /* Feature Grid with 3D effect */
            .feature-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
                gap: 2rem;
            }

            .feature-card {
                background: var(--bg-card);
                border: 1px solid var(--border-dark);
                border-radius: 1rem;
                padding: 2.5rem;
                transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                position: relative;
                overflow: hidden;
                transform-style: preserve-3d;
            }

            .feature-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 3px;
                background: linear-gradient(90deg, var(--accent-blue), var(--accent-purple));
                transform: scaleX(0);
                transition: transform 0.4s ease;
            }

            .feature-card::after {
                content: '';
                position: absolute;
                inset: 0;
                background: radial-gradient(circle at var(--mouse-x, 50%) var(--mouse-y, 50%), rgba(59, 130, 246, 0.1), transparent 50%);
                opacity: 0;
                transition: opacity 0.3s ease;
            }

            .feature-card:hover {
                border-color: var(--accent-blue);
                transform: translateY(-8px) rotateX(2deg);
                box-shadow: 0 20px 40px rgba(59, 130, 246, 0.2);
            }

            .feature-card:hover::before {
                transform: scaleX(1);
            }

            .feature-card:hover::after {
                opacity: 1;
            }

            .feature-icon {
                width: 60px;
                height: 60px;
                background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
                border-radius: 0.75rem;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.75rem;
                color: white;
                margin-bottom: 1.5rem;
                transition: transform 0.4s ease;
            }

            .feature-card:hover .feature-icon {
                transform: rotateY(360deg);
            }

            .feature-title {
                font-size: 1.35rem;
                font-weight: 700;
                margin-bottom: 0.75rem;
                position: relative;
                z-index: 1;
            }

            .feature-description {
                color: var(--text-gray-light);
                line-height: 1.7;
                position: relative;
                z-index: 1;
            }

            /* Comparison Section */
            .comparison {
                background: var(--bg-card);
                border-radius: 1rem;
                border: 1px solid var(--border-dark);
                padding: 4rem;
                margin: 4rem 0;
            }

            .comparison-title {
                text-align: center;
                font-size: 2.5rem;
                font-weight: 800;
                margin-bottom: 3rem;
            }

            .comparison-title .old {
                color: var(--text-gray);
            }

            .comparison-title .vs {
                color: var(--accent-blue);
                margin: 0 1rem;
            }

            .comparison-title .new {
                background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .comparison-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 3rem;
            }

            .comparison-col {
                padding: 2rem;
            }

            .comparison-col.old {
                border-right: 1px solid var(--border-dark);
            }

            .comparison-col-title {
                font-size: 1.5rem;
                font-weight: 700;
                margin-bottom: 2rem;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .comparison-col.old .comparison-col-title {
                color: var(--text-gray);
            }

            .comparison-col.new .comparison-col-title {
                color: var(--accent-blue);
            }

            .comparison-list {
                list-style: none;
                padding: 0;
            }

            .comparison-list li {
                padding: 1rem 0;
                display: flex;
                align-items: flex-start;
                gap: 1rem;
                border-bottom: 1px solid var(--border-dark);
                opacity: 0;
                transform: translateX(-20px);
                animation: slide-in 0.5s ease forwards;
            }

            .comparison-list li:nth-child(1) {
                animation-delay: 0.1s;
            }

            .comparison-list li:nth-child(2) {
                animation-delay: 0.2s;
            }

            .comparison-list li:nth-child(3) {
                animation-delay: 0.3s;
            }

            .comparison-list li:nth-child(4) {
                animation-delay: 0.4s;
            }

            .comparison-list li:nth-child(5) {
                animation-delay: 0.5s;
            }

            @keyframes slide-in {
                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }

            .comparison-list li:last-child {
                border-bottom: none;
            }

            .comparison-list li i {
                margin-top: 0.25rem;
            }

            .comparison-col.old li i {
                color: #ef4444;
            }

            .comparison-col.new li i {
                color: var(--success);
            }

            /* Role Cards */
            .role-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 2rem;
                margin-top: 3rem;
            }

            .role-card {
                background: var(--bg-card);
                border: 2px solid var(--border-dark);
                border-radius: 1rem;
                padding: 2.5rem;
                text-align: center;
                transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                cursor: pointer;
            }

            .role-card:hover {
                border-color: var(--accent-blue);
                transform: translateY(-10px) scale(1.02);
                box-shadow: 0 25px 50px rgba(59, 130, 246, 0.2);
            }

            .role-icon {
                width: 90px;
                height: 90px;
                background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
                border-radius: 1rem;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 2.5rem;
                color: white;
                margin: 0 auto 1.5rem;
                transition: transform 0.6s ease;
            }

            .role-card:hover .role-icon {
                transform: rotate(360deg) scale(1.1);
            }

            .role-title {
                font-size: 1.5rem;
                font-weight: 700;
                margin-bottom: 1.5rem;
            }

            .role-features {
                list-style: none;
                padding: 0;
                text-align: left;
            }

            .role-features li {
                padding: 0.75rem 0;
                display: flex;
                align-items: center;
                gap: 0.75rem;
                color: var(--text-gray-light);
                transition: transform 0.3s ease;
            }

            .role-features li:hover {
                transform: translateX(5px);
            }

            .role-features li i {
                color: var(--success);
                font-size: 0.875rem;
            }

            /* CTA Section with gradient animation */
            .cta-section {
                background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
                border-radius: 1rem;
                padding: 5rem 3rem;
                text-align: center;
                margin: 4rem 0;
                position: relative;
                overflow: hidden;
            }

            .cta-section::before {
                content: '';
                position: absolute;
                inset: 0;
                background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1), transparent);
                animation: shimmer 3s infinite;
            }

            @keyframes shimmer {
                0% {
                    transform: translateX(-100%);
                }

                100% {
                    transform: translateX(100%);
                }
            }

            .cta-section h2 {
                font-size: 3rem;
                font-weight: 800;
                margin-bottom: 1rem;
                position: relative;
            }

            .cta-section p {
                font-size: 1.25rem;
                margin-bottom: 2.5rem;
                opacity: 0.95;
                position: relative;
            }

            .cta-section .btn-primary {
                background: white;
                color: var(--accent-blue);
            }

            .cta-section .btn-primary:hover {
                background: var(--text-white);
                transform: translateY(-3px) scale(1.05);
            }

            .cta-section .btn-outline {
                border-color: white;
                color: white;
            }

            .cta-section .btn-outline:hover {
                background: rgba(255, 255, 255, 0.15);
            }

            /* Footer */
            .footer {
                background: var(--bg-card);
                border-top: 1px solid var(--border-dark);
                padding: 4rem 2rem 2rem;
                position: relative;
                z-index: 1;
            }

            .footer-content {
                max-width: 1200px;
                margin: 0 auto;
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 3rem;
                margin-bottom: 3rem;
            }

            .footer-section h4 {
                font-size: 1rem;
                font-weight: 700;
                margin-bottom: 1.25rem;
            }

            .footer-links {
                list-style: none;
                padding: 0;
            }

            .footer-links li {
                margin-bottom: 0.75rem;
            }

            .footer-links a {
                color: var(--text-gray);
                transition: all 0.3s ease;
            }

            .footer-links a:hover {
                color: var(--text-white);
                transform: translateX(5px);
                display: inline-block;
            }

            .footer-bottom {
                max-width: 1200px;
                margin: 0 auto;
                padding-top: 2rem;
                border-top: 1px solid var(--border-dark);
                display: flex;
                align-items: center;
                justify-content: space-between;
                color: var(--text-gray);
                font-size: 0.9rem;
            }

            .footer-social {
                display: flex;
                gap: 1.5rem;
            }

            .footer-social a {
                color: var(--text-gray);
                font-size: 1.25rem;
                transition: all 0.3s ease;
            }

            .footer-social a:hover {
                color: var(--accent-blue);
                transform: translateY(-3px);
            }

            /* Responsive */
            @media (max-width: 768px) {
                .nav-links {
                    display: none;
                }

                .hero-title {
                    font-size: 2.5rem;
                }

                .hero-subtitle {
                    font-size: 1.1rem;
                }

                .hero-stats {
                    grid-template-columns: 1fr;
                    gap: 2rem;
                }

                .comparison-grid {
                    grid-template-columns: 1fr;
                }

                .comparison-col.old {
                    border-right: none;
                    border-bottom: 1px solid var(--border-dark);
                }

                .role-grid {
                    grid-template-columns: 1fr;
                }

                .footer-content {
                    grid-template-columns: 1fr;
                }

                .section-title {
                    font-size: 2rem;
                }

                .hero-buttons {
                    flex-direction: column;
                    width: 100%;
                }

                .hero-buttons .btn {
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
            <div class="gradient-orb orb-3"></div>
        </div>

        <!-- Navigation -->
        <nav class="nav" id="nav">
            <div class="nav-container">
                <div class="nav-logo">
                    <i class="fas fa-brain"></i>
                    <span>NeuroBank</span>
                </div>

                <div class="nav-links">
                    <a href="#features" class="nav-link">Fonctionnalités</a>
                    <a href="#comparison" class="nav-link">Fonctionnement</a>
                    <a href="#roles" class="nav-link">Cas d'usage</a>
                    <a href="#" class="nav-link">Sécurité</a>
                </div>

                <div class="nav-actions">
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-ghost">Connexion</a>
                    <a href="${pageContext.request.contextPath}/inscription.jsp" class="btn btn-primary">Commencer</a>
                </div>
            </div>
        </nav>

        <!-- Hero Section -->
        <section class="hero">
            <div class="hero-content">
                <div class="hero-badge">
                    <i class="fas fa-sparkles"></i>
                    Propulsé par l'IA explicable
                </div>

                <h1 class="hero-title">
                    Plateforme de <span class="highlight">décision de prêt</span> par IA
                </h1>

                <p class="hero-subtitle">
                    Prenez des décisions de prêt plus intelligentes en 3 minutes grâce à l'IA explicable.
                    Automatisez les flux de travail, réduisez les risques et améliorez la précision d'approbation de
                    40%.
                </p>

                <div class="hero-buttons">
                    <a href="${pageContext.request.contextPath}/inscription.jsp" class="btn btn-primary">
                        Essai gratuit <i class="fas fa-arrow-right"></i>
                    </a>
                    <a href="#" class="btn btn-outline">
                        <i class="fas fa-play"></i> Voir la démo
                    </a>
                </div>

                <div class="hero-stats">
                    <div class="stat">
                        <div class="stat-value" data-target="500">0</div>
                        <div class="stat-label">Institutions financières</div>
                    </div>
                    <div class="stat">
                        <div class="stat-value" data-target="75">0</div>
                        <div class="stat-label">Décisions plus rapides</div>
                    </div>
                    <div class="stat">
                        <div class="stat-value" data-target="93">0</div>
                        <div class="stat-label">Précision de l'IA</div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section id="features" class="section fade-in">
            <div class="section-header">
                <span class="section-badge">Fonctionnalités</span>
                <h2 class="section-title">Pourquoi les institutions financières choisissent NeuroBank</h2>
                <p class="section-subtitle">Fonctionnalités puissantes conçues pour le prêt moderne</p>
            </div>

            <div class="feature-grid">
                <div class="feature-card fade-in">
                    <div class="feature-icon">
                        <i class="fas fa-brain"></i>
                    </div>
                    <h3 class="feature-title">IA explicable</h3>
                    <p class="feature-description">
                        Voyez exactement pourquoi chaque prêt est approuvé ou rejeté. Notre IA fournit un scoring
                        transparent avec des explications détaillées pour une conformité totale.
                    </p>
                </div>

                <div class="feature-card fade-in">
                    <div class="feature-icon">
                        <i class="fas fa-bolt"></i>
                    </div>
                    <h3 class="feature-title">Ultra rapide</h3>
                    <p class="feature-description">
                        Réduisez le temps de traitement de plusieurs jours à quelques minutes. Gérez 10 fois plus de
                        demandes avec des workflows automatisés et une analyse IA instantanée.
                    </p>
                </div>

                <div class="feature-card fade-in">
                    <div class="feature-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h3 class="feature-title">Sécurité bancaire</h3>
                    <p class="feature-description">
                        Certifié ISO 27001 avec chiffrement de bout en bout. Vos données sont protégées avec les mêmes
                        standards utilisés par les grandes banques.
                    </p>
                </div>

                <div class="feature-card fade-in">
                    <div class="feature-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h3 class="feature-title">Analytiques en temps réel</h3>
                    <p class="feature-description">
                        Suivez les performances, les taux d'approbation et la santé du portefeuille instantanément avec
                        des tableaux de bord et rapports complets.
                    </p>
                </div>

                <div class="feature-card fade-in">
                    <div class="feature-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3 class="feature-title">Plateforme multi-rôles</h3>
                    <p class="feature-description">
                        Expérience fluide pour les emprunteurs, agents de crédit et administrateurs. Chaque rôle dispose
                        d'une interface sur mesure et optimisée.
                    </p>
                </div>

                <div class="feature-card fade-in">
                    <div class="feature-icon">
                        <i class="fas fa-clipboard-check"></i>
                    </div>
                    <h3 class="feature-title">Conformité totale</h3>
                    <p class="feature-description">
                        Pistes d'audit automatisées pour chaque décision. Conforme RGPD avec capacités de reporting
                        réglementaire intégrées.
                    </p>
                </div>
            </div>
        </section>

        <!-- Comparison Section -->
        <section id="comparison" class="section">
            <div class="comparison fade-in">
                <h2 class="comparison-title">
                    <span class="old">Prêt traditionnel</span>
                    <span class="vs">vs</span>
                    <span class="new">NeuroBank</span>
                </h2>

                <div class="comparison-grid">
                    <div class="comparison-col old slide-left">
                        <h3 class="comparison-col-title">
                            <i class="fas fa-times-circle"></i> Ancienne méthode
                        </h3>
                        <ul class="comparison-list">
                            <li>
                                <i class="fas fa-times"></i>
                                <span>Examen manuel prenant 5-7 jours</span>
                            </li>
                            <li>
                                <i class="fas fa-times"></i>
                                <span>Prise de décision subjective</span>
                            </li>
                            <li>
                                <i class="fas fa-times"></i>
                                <span>Capacité de traitement limitée</span>
                            </li>
                            <li>
                                <i class="fas fa-times"></i>
                                <span>Aucune transparence pour les emprunteurs</span>
                            </li>
                            <li>
                                <i class="fas fa-times"></i>
                                <span>Suivi de conformité difficile</span>
                            </li>
                        </ul>
                    </div>

                    <div class="comparison-col new slide-right">
                        <h3 class="comparison-col-title">
                            <i class="fas fa-check-circle"></i> Méthode NeuroBank
                        </h3>
                        <ul class="comparison-list">
                            <li>
                                <i class="fas fa-check"></i>
                                <span>Analyse IA instantanée en 3 minutes</span>
                            </li>
                            <li>
                                <i class="fas fa-check"></i>
                                <span>Décisions basées sur les données, explicables</span>
                            </li>
                            <li>
                                <i class="fas fa-check"></i>
                                <span>Gérez 10 fois plus de demandes</span>
                            </li>
                            <li>
                                <i class="fas fa-check"></i>
                                <span>Statut en temps réel et retours clairs</span>
                            </li>
                            <li>
                                <i class="fas fa-check"></i>
                                <span>Pistes d'audit automatisées intégrées</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </section>

        <!-- Roles Section -->
        <section id="roles" class="section">
            <div class="section-header fade-in">
                <span class="section-badge">Cas d'usage</span>
                <h2 class="section-title">Conçu pour chaque rôle</h2>
                <p class="section-subtitle">Expériences sur mesure pour les emprunteurs, agents de crédit et
                    administrateurs</p>
            </div>

            <div class="role-grid">
                <div class="role-card fade-in">
                    <div class="role-icon">
                        <i class="fas fa-user"></i>
                    </div>
                    <h3 class="role-title">Pour les emprunteurs</h3>
                    <ul class="role-features">
                        <li><i class="fas fa-check-circle"></i> Postulez en 5 minutes</li>
                        <li><i class="fas fa-check-circle"></i> Obtenez une pré-approbation IA instantanée</li>
                        <li><i class="fas fa-check-circle"></i> Suivez le statut en temps réel</li>
                        <li><i class="fas fa-check-circle"></i> Recevez des retours transparents</li>
                        <li><i class="fas fa-check-circle"></i> Gérez plusieurs demandes</li>
                    </ul>
                </div>

                <div class="role-card fade-in">
                    <div class="role-icon">
                        <i class="fas fa-user-tie"></i>
                    </div>
                    <h3 class="role-title">Pour les agents de crédit</h3>
                    <ul class="role-features">
                        <li><i class="fas fa-check-circle"></i> Examinez des demandes enrichies</li>
                        <li><i class=" fas fa-check-circle"></i> Prise de décision assistée par IA</li>
                        <li><i class="fas fa-check-circle"></i> Gérez tout le portefeuille</li>
                        <li><i class="fas fa-check-circle"></i> Filtrage et recherche avancés</li>
                        <li><i class="fas fa-check-circle"></i> Tableaux de bord de performance</li>
                    </ul>
                </div>

                <div class="role-card fade-in">
                    <div class="role-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h3 class="role-title">Pour les administrateurs bancaires</h3>
                    <ul class="role-features">
                        <li><i class="fas fa-check-circle"></i> Surveillez les performances globales</li>
                        <li><i class="fas fa-check-circle"></i> Assurez la conformité</li>
                        <li><i class="fas fa-check-circle"></i> Gérez l'équipe et les utilisateurs</li>
                        <li><i class="fas fa-check-circle"></i> Exportez des rapports complets</li>
                        <li><i class="fas fa-check-circle"></i> Configurez les paramètres IA</li>
                    </ul>
                </div>
            </div>
        </section>

        <!-- CTA Section -->
        <section class="section">
            <div class="cta-section fade-in">
                <h2>Prêt à transformer vos opérations de prêt ?</h2>
                <p>Rejoignez les 500+ institutions financières utilisant NeuroBank pour des décisions de prêt plus
                    intelligentes et rapides.</p>
                <div class="hero-buttons">
                    <a href="${pageContext.request.contextPath}/inscription.jsp" class="btn btn-primary">
                        Essai gratuit <i class="fas fa-arrow-right"></i>
                    </a>
                    <a href="#" class="btn btn-outline">
                        <i class="fas fa-calendar"></i> Planifier une démo
                    </a>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="footer">
            <div class="footer-content">
                <div class="footer-section">
                    <h4>Produit</h4>
                    <ul class="footer-links">
                        <li><a href="#features">Fonctionnalités</a></li>
                        <li><a href="#comparison">Fonctionnement</a></li>
                        <li><a href="#roles">Cas d'usage</a></li>
                        <li><a href="#">Tarifs</a></li>
                        <li><a href="#">API</a></li>
                    </ul>
                </div>

                <div class="footer-section">
                    <h4>Entreprise</h4>
                    <ul class="footer-links">
                        <li><a href="#">À propos</a></li>
                        <li><a href="#">Carrières</a></li>
                        <li><a href="#">Blog</a></li>
                        <li><a href="#">Kit presse</a></li>
                        <li><a href="#">Contact</a></li>
                    </ul>
                </div>

                <div class="footer-section">
                    <h4>Ressources</h4>
                    <ul class="footer-links">
                        <li><a href="#">Documentation</a></li>
                        <li><a href="#">Centre d'aide</a></li>
                        <li><a href="#">Référence API</a></li>
                        <li><a href="#">Études de cas</a></li>
                        <li><a href="#">Webinaires</a></li>
                    </ul>
                </div>

                <div class="footer-section">
                    <h4>Légal</h4>
                    <ul class="footer-links">
                        <li><a href="#">Politique de confidentialité</a></li>
                        <li><a href="#">Conditions d'utilisation</a></li>
                        <li><a href="#">Politique de cookies</a></li>
                        <li><a href="#">GDPR</a></li>
                        <li><a href="#">Conformité</a></li>
                    </ul>
                </div>
            </div>

            <div class="footer-bottom">
                <div>&copy; 2026 NeuroBank. All rights reserved.</div>
                <div class="footer-social">
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-linkedin"></i></a>
                    <a href="#"><i class="fab fa-github"></i></a>
                </div>
            </div>
        </footer>

        <script>
            // Scroll-triggered animations
            const observerOptions = {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            };

            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('visible');
                    }
                });
            }, observerOptions);

            document.querySelectorAll('.fade-in, .slide-left, .slide-right').forEach(el => {
                observer.observe(el);
            });

            // Navbar scroll effect
            const nav = document.getElementById('nav');
            window.addEventListener('scroll', () => {
                if (window.scrollY > 100) {
                    nav.classList.add('scrolled');
                } else {
                    nav.classList.remove('scrolled');
                }
            });

            // Counter animation for stats
            const animateCounter = (element) => {
                const target = parseInt(element.dataset.target);
                const duration = 2000;
                const step = target / (duration / 16);
                let current = 0;

                const updateCounter = () => {
                    current += step;
                    if (current < target) {
                        element.textContent = Math.floor(current) + (target > 100 ? '' : '%');
                        requestAnimationFrame(updateCounter);
                    } else {
                        element.textContent = target + (target > 100 ? '+' : '%');
                    }
                };

                updateCounter();
            };

            // Trigger counter animation when stats are visible
            const statsObserver = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const statValues = entry.target.querySelectorAll('.stat-value');
                        statValues.forEach(stat => {
                            if (!stat.classList.contains('animated')) {
                                animateCounter(stat);
                                stat.classList.add('animated');
                            }
                        });
                    }
                });
            }, { threshold: 0.5 });

            const heroStats = document.querySelector('.hero-stats');
            if (heroStats) {
                statsObserver.observe(heroStats);
            }

            // Feature card mouse tracking
            document.querySelectorAll('.feature-card').forEach(card => {
                card.addEventListener('mousemove', (e) => {
                    const rect = card.getBoundingClientRect();
                    const x = ((e.clientX - rect.left) / rect.width) * 100;
                    const y = ((e.clientY - rect.top) / rect.height) * 100;
                    card.style.setProperty('--mouse-x', x + '%');
                    card.style.setProperty('--mouse-y', y + '%');
                });
            });

            // Smooth scroll for anchor links
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    const href = this.getAttribute('href');
                    if (href !== '#') {
                        e.preventDefault();
                        const element = document.querySelector(href);
                        if (element) {
                            const offsetTop = element.offsetTop - 80;
                            window.scrollTo({
                                top: offsetTop,
                                behavior: 'smooth'
                            });
                        }
                    }
                });
            });
        </script>
    </body>

    </html>