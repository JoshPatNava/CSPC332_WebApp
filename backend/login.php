<?php
session_start();
require_once 'config.php';

if (isset($_SESSION['employee_id'])) {
    header('Location: dashboard.php');
    exit;
}

$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($_POST['email'] ?? '');
    $password = $_POST['password'] ?? '';

    if (empty($email) || empty($password)) {
        $error = 'Please enter both email and password.';
    } else {
        $stmt = $pdo->prepare("SELECT employee_id, FName, LName, password FROM Employee WHERE email = ?");
        $stmt->execute([$email]);
        $user = $stmt->fetch();

        if ($user && $password === $user['password']) {
            $_SESSION['employee_id'] = $user['employee_id'];
            $_SESSION['employee_name'] = $user['FName'] . ' ' . $user['LName'];
            header('Location: dashboard.php');
            exit;
        } else {
            $error = 'Invalid email or password.';
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - ABC Cinema</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="styles.css" rel="stylesheet">
</head>
<body class="text-white">

    <div class="container">
        <div class="row justify-content-center" style="padding-top: 80px;">
            <div class="col-md-5 col-lg-4">
                <a href="index.php" class="back-link">&larr; Back to Home</a>
                
                <div class="auth-card">
                    <div class="auth-header">
                        <div class="d-flex justify-content-center mb-3">
                            <svg width="56" height="56" viewBox="0 0 36 36" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <circle cx="18" cy="18" r="17" stroke="url(#logoRing2)" stroke-width="2"/>
                                <circle cx="18" cy="18" r="12" fill="url(#logoFill2)"/>
                                <path d="M15 12.5V23.5L25 18L15 12.5Z" fill="white"/>
                                <defs>
                                    <linearGradient id="logoRing2" x1="0" y1="0" x2="36" y2="36" gradientUnits="userSpaceOnUse">
                                        <stop stop-color="#60a5fa"/>
                                        <stop offset="1" stop-color="#a78bfa"/>
                                    </linearGradient>
                                    <linearGradient id="logoFill2" x1="6" y1="6" x2="30" y2="30" gradientUnits="userSpaceOnUse">
                                        <stop stop-color="#3b82f6"/>
                                        <stop offset="1" stop-color="#8b5cf6"/>
                                    </linearGradient>
                                </defs>
                            </svg>
                        </div>
                        <h4 class="mb-1">Welcome Back</h4>
                        <small class="text-white-50">Sign in to ABC Cinema</small>
                    </div>
                    <div class="auth-body">
                        <?php if ($error): ?>
                            <div class="alert alert-danger"><?php echo htmlspecialchars($error); ?></div>
                        <?php endif; ?>

                        <form method="POST">
                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email" placeholder="you@example.com" required>
                            </div>
                            <div class="mb-4">
                                <label class="form-label">Password</label>
                                <input type="password" class="form-control" name="password" placeholder="Enter password" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Sign In</button>
                        </form>
                    </div>
                    <div class="auth-footer">
                        <small>Don't have an account? <a href="signup.php">Create one</a></small>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
