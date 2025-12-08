<?php
session_start();
require_once 'config.php';

if (!isset($_SESSION['employee_id'])) {
    header('Location: login.php');
    exit;
}

$employeeName = $_SESSION['employee_name'] ?? 'Employee';
$tab = $_GET['tab'] ?? 'movies';

$filterCinema = $_GET['cinema'] ?? '';
$filterDate = $_GET['date'] ?? '';
$filterMovie = $_GET['movie'] ?? '';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - ABC Cinema</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="styles.css" rel="stylesheet">
</head>
<body class="text-white">
    <nav class="navbar navbar-custom py-2">
        <div class="container-fluid px-4">
            <a href="index.php" class="navbar-brand text-white text-decoration-none d-flex align-items-center gap-2">
                <svg width="32" height="32" viewBox="0 0 36 36" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <circle cx="18" cy="18" r="17" stroke="url(#logoRing4)" stroke-width="2"/>
                    <circle cx="18" cy="18" r="12" fill="url(#logoFill4)"/>
                    <path d="M15 12.5V23.5L25 18L15 12.5Z" fill="white"/>
                    <defs>
                        <linearGradient id="logoRing4" x1="0" y1="0" x2="36" y2="36" gradientUnits="userSpaceOnUse">
                            <stop stop-color="#60a5fa"/>
                            <stop offset="1" stop-color="#a78bfa"/>
                        </linearGradient>
                        <linearGradient id="logoFill4" x1="6" y1="6" x2="30" y2="30" gradientUnits="userSpaceOnUse">
                            <stop stop-color="#3b82f6"/>
                            <stop offset="1" stop-color="#8b5cf6"/>
                        </linearGradient>
                    </defs>
                </svg>
                <span class="brand-text">ABC Cinema</span>
            </a>
            <div class="d-flex align-items-center">
                <span class="welcome-text me-3">Welcome, <strong><?php echo htmlspecialchars($employeeName); ?></strong></span>
                <a href="logout.php" class="btn btn-outline-light btn-sm">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2 sidebar">
                <div class="sidebar-section-title">Main Menu</div>
                <nav class="nav flex-column">
                    <a class="nav-link <?php echo $tab === 'movies' ? 'active' : ''; ?>" href="?tab=movies">
                        <svg class="nav-icon-svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="2" width="20" height="20" rx="2.18" ry="2.18"></rect><line x1="7" y1="2" x2="7" y2="22"></line><line x1="17" y1="2" x2="17" y2="22"></line><line x1="2" y1="12" x2="22" y2="12"></line><line x1="2" y1="7" x2="7" y2="7"></line><line x1="2" y1="17" x2="7" y2="17"></line><line x1="17" y1="17" x2="22" y2="17"></line><line x1="17" y1="7" x2="22" y2="7"></line></svg>
                        Movies
                    </a>
                    <a class="nav-link <?php echo $tab === 'showtimes' ? 'active' : ''; ?>" href="?tab=showtimes">
                        <svg class="nav-icon-svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                        Showtimes
                    </a>
                    <a class="nav-link <?php echo $tab === 'cinemas' ? 'active' : ''; ?>" href="?tab=cinemas">
                        <svg class="nav-icon-svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
                        Cinemas
                    </a>
                    <a class="nav-link <?php echo $tab === 'auditoriums' ? 'active' : ''; ?>" href="?tab=auditoriums">
                        <svg class="nav-icon-svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><line x1="3" y1="9" x2="21" y2="9"></line><line x1="9" y1="21" x2="9" y2="9"></line></svg>
                        Auditoriums
                    </a>
                </nav>
            </div>
            <div class="col-md-10 p-4 dashboard-content">

                <?php if ($tab === 'movies'): ?>
                    <h2 class="page-title">Movies</h2>
                    <?php
                    $movies = $pdo->query("
                        SELECT m.movie_id, m.title, m.year, m.duration_minutes, m.description, m.release_date, r.name as rating,
                               GROUP_CONCAT(g.genre_name SEPARATOR ', ') as genres
                        FROM Movie m
                        LEFT JOIN Rating r ON m.rating_id = r.rating_id
                        LEFT JOIN MovieGenre mg ON m.movie_id = mg.movie_id
                        LEFT JOIN Genre g ON mg.genre_id = g.genre_id
                        GROUP BY m.movie_id 
                        ORDER BY m.year DESC, m.title
                    ")->fetchAll();
                    ?>
                    <div class="row g-4">
                        <?php if (empty($movies)): ?>
                            <div class="col-12">
                                <p class="empty-state">No movies found</p>
                            </div>
                        <?php else: ?>
                            <?php foreach ($movies as $movie): 
                                $ratingClass = 'bg-info';
                                $r = strtoupper($movie['rating'] ?? '');
                                if ($r === 'G') $ratingClass = 'badge-g';
                                elseif ($r === 'PG') $ratingClass = 'badge-pg';
                                elseif ($r === 'PG-13') $ratingClass = 'badge-pg13';
                                elseif ($r === 'R') $ratingClass = 'badge-r';
                            ?>
                            <div class="col-md-6 col-lg-4">
                                <div class="movie-card">
                                    <div class="movie-card-header">
                                        <h5 class="movie-title"><?php echo htmlspecialchars($movie['title']); ?></h5>
                                        <span class="badge <?php echo $ratingClass; ?>"><?php echo htmlspecialchars($movie['rating'] ?? 'N/A'); ?></span>
                                    </div>
                                    <p class="movie-description"><?php echo htmlspecialchars($movie['description'] ?? 'No description available.'); ?></p>
                                    <div class="movie-meta">
                                        <div class="movie-meta-item">
                                            <span class="meta-label">Year</span>
                                            <span class="meta-value"><?php echo htmlspecialchars($movie['year']); ?></span>
                                        </div>
                                        <div class="movie-meta-item">
                                            <span class="meta-label">Duration</span>
                                            <span class="meta-value"><?php echo htmlspecialchars($movie['duration_minutes']); ?> min</span>
                                        </div>
                                        <div class="movie-meta-item">
                                            <span class="meta-label">Released</span>
                                            <span class="meta-value"><?php echo date('M j, Y', strtotime($movie['release_date'])); ?></span>
                                        </div>
                                    </div>
                                    <div class="movie-genres">
                                        <?php 
                                        $genres = explode(', ', $movie['genres'] ?? '');
                                        foreach ($genres as $genre): 
                                            if (!empty(trim($genre))):
                                        ?>
                                            <span class="genre-tag"><?php echo htmlspecialchars(trim($genre)); ?></span>
                                        <?php 
                                            endif;
                                        endforeach; 
                                        ?>
                                    </div>
                                </div>
                            </div>
                            <?php endforeach; ?>
                        <?php endif; ?>
                    </div>
                <?php endif; ?>

                <?php if ($tab === 'showtimes'): ?>
                    <h2 class="page-title">Showtimes</h2>
                    
                    <?php
                    $cinemaOptions = $pdo->query("SELECT cinema_id, name FROM Cinema ORDER BY name")->fetchAll();
                    $movieOptions = $pdo->query("SELECT movie_id, title FROM Movie ORDER BY title")->fetchAll();
                    ?>
                    <div class="filter-card mb-4">
                        <form method="GET" class="row g-3 align-items-end">
                            <input type="hidden" name="tab" value="showtimes">
                            <div class="col-md-3">
                                <label class="form-label">Cinema</label>
                                <select class="form-select" name="cinema">
                                    <option value="">All Cinemas</option>
                                    <?php foreach ($cinemaOptions as $c): ?>
                                        <option value="<?php echo $c['cinema_id']; ?>" <?php echo $filterCinema == $c['cinema_id'] ? 'selected' : ''; ?>>
                                            <?php echo htmlspecialchars($c['name']); ?>
                                        </option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Movie</label>
                                <select class="form-select" name="movie">
                                    <option value="">All Movies</option>
                                    <?php foreach ($movieOptions as $m): ?>
                                        <option value="<?php echo $m['movie_id']; ?>" <?php echo $filterMovie == $m['movie_id'] ? 'selected' : ''; ?>>
                                            <?php echo htmlspecialchars($m['title']); ?>
                                        </option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Date</label>
                                <input type="date" class="form-control" name="date" value="<?php echo htmlspecialchars($filterDate); ?>">
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-primary me-2">Search</button>
                                <a href="?tab=showtimes" class="btn btn-outline-light">Clear</a>
                            </div>
                        </form>
                    </div>

                    <?php
                    $sql = "
                        SELECT s.show_id, m.title as movie, c.name as cinema, a.name as auditorium,
                               s.start_time, s.end_time, s.format
                        FROM Shows s
                        JOIN Movie m ON s.movie_id = m.movie_id
                        JOIN Auditorium a ON s.auditorium_id = a.auditorium_id
                        JOIN Cinema c ON a.cinema_id = c.cinema_id
                        WHERE 1=1
                    ";
                    $params = [];

                    if (!empty($filterCinema)) {
                        $sql .= " AND c.cinema_id = ?";
                        $params[] = $filterCinema;
                    }
                    if (!empty($filterMovie)) {
                        $sql .= " AND m.movie_id = ?";
                        $params[] = $filterMovie;
                    }
                    if (!empty($filterDate)) {
                        $sql .= " AND DATE(s.start_time) = ?";
                        $params[] = $filterDate;
                    }

                    $sql .= " ORDER BY s.start_time DESC";

                    $stmt = $pdo->prepare($sql);
                    $stmt->execute($params);
                    $showtimes = $stmt->fetchAll();
                    ?>
                    <div class="card-custom">
                        <table class="table table-custom">
                            <thead>
                                <tr>
                                    <th>Movie</th>
                                    <th>Cinema</th>
                                    <th>Auditorium</th>
                                    <th>Date</th>
                                    <th>Time</th>
                                    <th>Format</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if (empty($showtimes)): ?>
                                    <tr><td colspan="6" class="empty-state">No showtimes found</td></tr>
                                <?php else: ?>
                                    <?php foreach ($showtimes as $show): ?>
                                    <tr>
                                        <td><strong class="text-white"><?php echo htmlspecialchars($show['movie']); ?></strong></td>
                                        <td><?php echo htmlspecialchars($show['cinema']); ?></td>
                                        <td><?php echo htmlspecialchars($show['auditorium']); ?></td>
                                        <td><?php echo date('M j, Y', strtotime($show['start_time'])); ?></td>
                                        <td><?php echo date('g:i A', strtotime($show['start_time'])); ?> - <?php echo date('g:i A', strtotime($show['end_time'])); ?></td>
                                        <td>
                                            <?php if ($show['format'] === '3D'): ?>
                                                <span class="badge bg-success">3D</span>
                                            <?php else: ?>
                                                <span class="badge bg-secondary">Regular</span>
                                            <?php endif; ?>
                                        </td>
                                    </tr>
                                    <?php endforeach; ?>
                                <?php endif; ?>
                            </tbody>
                        </table>
                    </div>
                <?php endif; ?>

                <?php if ($tab === 'cinemas'): ?>
                    <h2 class="page-title">Cinemas</h2>
                    <?php
                    $cinemas = $pdo->query("
                        SELECT c.cinema_id, c.name, c.street_num, c.street, c.city, c.state, c.zip,
                               COUNT(a.auditorium_id) as auditorium_count,
                               SUM(a.capacity) as total_seats
                        FROM Cinema c
                        LEFT JOIN Auditorium a ON c.cinema_id = a.cinema_id
                        GROUP BY c.cinema_id
                        ORDER BY c.name
                    ")->fetchAll();
                    ?>
                    <div class="row g-4">
                        <?php if (empty($cinemas)): ?>
                            <div class="col-12">
                                <p class="empty-state">No cinemas found</p>
                            </div>
                        <?php else: ?>
                            <?php foreach ($cinemas as $cinema): ?>
                            <div class="col-md-6 col-lg-4">
                                <div class="cinema-card">
                                    <h5><?php echo htmlspecialchars($cinema['name']); ?></h5>
                                    <p class="mb-1"><?php echo htmlspecialchars($cinema['street_num'] . ' ' . $cinema['street']); ?></p>
                                    <p class="mb-3"><?php echo htmlspecialchars($cinema['city'] . ', ' . $cinema['state'] . ' ' . $cinema['zip']); ?></p>
                                    <div class="d-flex gap-2">
                                        <span class="badge bg-primary"><?php echo $cinema['auditorium_count']; ?> auditoriums</span>
                                        <span class="badge bg-secondary"><?php echo number_format($cinema['total_seats'] ?? 0); ?> seats</span>
                                    </div>
                                </div>
                            </div>
                            <?php endforeach; ?>
                        <?php endif; ?>
                    </div>
                <?php endif; ?>

                <?php if ($tab === 'auditoriums'): ?>
                    <h2 class="page-title">Auditoriums</h2>
                    <?php
                    $auditoriums = $pdo->query("
                        SELECT a.auditorium_id, a.name, c.name as cinema, a.capacity, a.supports_3d, a.supports_imax
                        FROM Auditorium a
                        JOIN Cinema c ON a.cinema_id = c.cinema_id
                        ORDER BY c.name, a.name
                    ")->fetchAll();
                    ?>
                    <div class="card-custom">
                        <table class="table table-custom">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Cinema</th>
                                    <th>Capacity</th>
                                    <th>3D Support</th>
                                    <th>IMAX</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if (empty($auditoriums)): ?>
                                    <tr><td colspan="5" class="empty-state">No auditoriums found</td></tr>
                                <?php else: ?>
                                    <?php foreach ($auditoriums as $aud): ?>
                                    <tr>
                                        <td><strong class="text-white"><?php echo htmlspecialchars($aud['name']); ?></strong></td>
                                        <td><?php echo htmlspecialchars($aud['cinema']); ?></td>
                                        <td><?php echo number_format($aud['capacity']); ?> seats</td>
                                        <td>
                                            <?php if ($aud['supports_3d']): ?>
                                                <span class="badge bg-success">Yes</span>
                                            <?php else: ?>
                                                <span class="badge bg-secondary">No</span>
                                            <?php endif; ?>
                                        </td>
                                        <td>
                                            <?php if ($aud['supports_imax']): ?>
                                                <span class="badge bg-success">Yes</span>
                                            <?php else: ?>
                                                <span class="badge bg-secondary">No</span>
                                            <?php endif; ?>
                                        </td>
                                    </tr>
                                    <?php endforeach; ?>
                                <?php endif; ?>
                            </tbody>
                        </table>
                    </div>
                <?php endif; ?>

            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
