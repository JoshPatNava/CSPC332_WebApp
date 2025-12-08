<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ABC Cinema - Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="styles.css" rel="stylesheet">
</head>
<body class="text-white">
    <nav class="navbar navbar-custom py-3 fixed-top">
        <div class="container">
            <a class="navbar-brand text-white text-decoration-none d-flex align-items-center gap-2" href="index.php">
                <svg width="36" height="36" viewBox="0 0 36 36" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <circle cx="18" cy="18" r="17" stroke="url(#logoRing1)" stroke-width="2"/>
                    <circle cx="18" cy="18" r="12" fill="url(#logoFill1)"/>
                    <path d="M15 12.5V23.5L25 18L15 12.5Z" fill="white"/>
                    <defs>
                        <linearGradient id="logoRing1" x1="0" y1="0" x2="36" y2="36" gradientUnits="userSpaceOnUse">
                            <stop stop-color="#60a5fa"/>
                            <stop offset="1" stop-color="#a78bfa"/>
                        </linearGradient>
                        <linearGradient id="logoFill1" x1="6" y1="6" x2="30" y2="30" gradientUnits="userSpaceOnUse">
                            <stop stop-color="#3b82f6"/>
                            <stop offset="1" stop-color="#8b5cf6"/>
                        </linearGradient>
                    </defs>
                </svg>
                <span class="brand-text">ABC Cinema</span>
            </a>
            <div>
                <a href="login.php" class="btn btn-outline-light me-2">Login</a>
                <a href="signup.php" class="btn btn-primary">Sign Up</a>
            </div>
        </div>
    </nav>
    <div class="container hero-section text-center" style="padding-top: 140px;">
        <h1 class="hero-title">Cinema Management System</h1>
        <p class="hero-subtitle mb-5">Manage your cinema operations with ease. Track movies, schedule showtimes, and oversee auditoriums all in one place.</p>
        <div>
            <a href="signup.php" class="btn btn-primary btn-lg me-3">Get Started</a>
            <a href="login.php" class="btn btn-outline-light btn-lg">Employee Login</a>
        </div>
    </div>
    <div class="container py-5">
        <h2 class="section-title">Features</h2>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="feature-card">
                    <div class="feature-icon">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="2" width="20" height="20" rx="2.18" ry="2.18"></rect><line x1="7" y1="2" x2="7" y2="22"></line><line x1="17" y1="2" x2="17" y2="22"></line><line x1="2" y1="12" x2="22" y2="12"></line><line x1="2" y1="7" x2="7" y2="7"></line><line x1="2" y1="17" x2="7" y2="17"></line><line x1="17" y1="17" x2="22" y2="17"></line><line x1="17" y1="7" x2="22" y2="7"></line></svg>
                    </div>
                    <h5>Movie Management</h5>
                    <p>Track movies, genres, ratings, and release dates across all your cinema locations.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <div class="feature-icon">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                    </div>
                    <h5>Showtime Scheduling</h5>
                    <p>Schedule screenings across multiple auditoriums with support for 3D and IMAX formats.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <div class="feature-icon">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
                    </div>
                    <h5>Auditorium Tracking</h5>
                    <p>Manage seating capacity and special features like 3D and IMAX capabilities.</p>
                </div>
            </div>
        </div>
    </div>

    <div class="footer-spacer"></div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
