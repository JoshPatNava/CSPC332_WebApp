<?php
session_start();
require_once 'config.php';

if (isset($_SESSION['employee_id'])) {
    header('Location: dashboard.php');
    exit;
}

$error = '';
$success = '';

try {
    $roles = $pdo->query("SELECT role_id, role_name FROM Role ORDER BY role_name")->fetchAll();
    $cinemas = $pdo->query("SELECT cinema_id, name FROM Cinema ORDER BY name")->fetchAll();
} catch (PDOException $e) {
    $roles = [];
    $cinemas = [];
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $firstName = trim($_POST['firstName'] ?? '');
    $lastName = trim($_POST['lastName'] ?? '');
    $streetNum = trim($_POST['streetNum'] ?? '');
    $street = trim($_POST['street'] ?? '');
    $city = trim($_POST['city'] ?? '');
    $state = trim($_POST['state'] ?? '');
    $zip = trim($_POST['zip'] ?? '');
    $phone = trim($_POST['phone'] ?? '');
    $email = trim($_POST['email'] ?? '');
    $password = $_POST['password'] ?? '';
    $confirmPassword = $_POST['confirmPassword'] ?? '';
    $roleId = $_POST['role'] ?? '';
    $cinemaId = $_POST['cinema'] ?? '';

    if (empty($firstName) || empty($lastName) || empty($email) || empty($password)) {
        $error = 'Please fill in all required fields.';
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $error = 'Please enter a valid email address.';
    } elseif ($password !== $confirmPassword) {
        $error = 'Passwords do not match.';
    } elseif (strlen($password) < 8) {
        $error = 'Password must be at least 8 characters.';
    } elseif (!preg_match('/[A-Z]/', $password) || !preg_match('/[a-z]/', $password) || !preg_match('/[0-9]/', $password) || !preg_match('/[^A-Za-z0-9]/', $password)) {
        $error = 'Password must include uppercase, lowercase, number, and special character.';
    } else {
        $check = $pdo->prepare("SELECT employee_id FROM Employee WHERE email = ?");
        $check->execute([$email]);
        
        if ($check->fetch()) {
            $error = 'This email is already registered.';
        } else {
            try {
                $stmt = $pdo->prepare("INSERT INTO Employee (FName, LName, phone, email, street_num, street, city, state, zip, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                $stmt->execute([$firstName, $lastName, $phone, $email, $streetNum, $street, $city, $state, $zip, $password]);
                
                $employeeId = $pdo->lastInsertId();

                if (!empty($roleId)) {
                    $pdo->prepare("INSERT INTO EmployeeRole (employee_id, role_id) VALUES (?, ?)")->execute([$employeeId, $roleId]);
                }
                if (!empty($cinemaId)) {
                    $pdo->prepare("INSERT INTO WorkFor (cinema_id, employee_id) VALUES (?, ?)")->execute([$cinemaId, $employeeId]);
                }

                $success = 'Account created successfully! You can now sign in.';
            } catch (PDOException $e) {
                $error = 'Registration failed. Please try again.';
            }
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - ABC Cinema</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="styles.css" rel="stylesheet">
</head>
<body class="text-white">

    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-md-7 col-lg-6">
                <a href="index.php" class="back-link">&larr; Back to Home</a>
                
                <div class="auth-card">
                    <div class="auth-header">
                        <div class="d-flex justify-content-center mb-3">
                            <svg width="56" height="56" viewBox="0 0 36 36" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <circle cx="18" cy="18" r="17" stroke="url(#logoRing3)" stroke-width="2"/>
                                <circle cx="18" cy="18" r="12" fill="url(#logoFill3)"/>
                                <path d="M15 12.5V23.5L25 18L15 12.5Z" fill="white"/>
                                <defs>
                                    <linearGradient id="logoRing3" x1="0" y1="0" x2="36" y2="36" gradientUnits="userSpaceOnUse">
                                        <stop stop-color="#60a5fa"/>
                                        <stop offset="1" stop-color="#a78bfa"/>
                                    </linearGradient>
                                    <linearGradient id="logoFill3" x1="6" y1="6" x2="30" y2="30" gradientUnits="userSpaceOnUse">
                                        <stop stop-color="#3b82f6"/>
                                        <stop offset="1" stop-color="#8b5cf6"/>
                                    </linearGradient>
                                </defs>
                            </svg>
                        </div>
                        <h4 class="mb-1">Create Account</h4>
                        <small class="text-white-50">Join the ABC Cinema team</small>
                    </div>
                    <div class="auth-body">
                        <?php if ($error): ?>
                            <div class="alert alert-danger"><?php echo htmlspecialchars($error); ?></div>
                        <?php endif; ?>
                        <?php if ($success): ?>
                            <div class="alert alert-success">
                                <?php echo htmlspecialchars($success); ?>
                                <br><a href="login.php" class="text-white fw-bold">Click here to sign in &rarr;</a>
                            </div>
                        <?php endif; ?>

                        <form method="POST">
                            <div class="row mb-3">
                                <div class="col-6">
                                    <label class="form-label">First Name *</label>
                                    <input type="text" class="form-control" name="firstName" value="<?php echo htmlspecialchars($_POST['firstName'] ?? ''); ?>" required>
                                </div>
                                <div class="col-6">
                                    <label class="form-label">Last Name *</label>
                                    <input type="text" class="form-control" name="lastName" value="<?php echo htmlspecialchars($_POST['lastName'] ?? ''); ?>" required>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-3">
                                    <label class="form-label">Street #</label>
                                    <input type="text" class="form-control" name="streetNum" value="<?php echo htmlspecialchars($_POST['streetNum'] ?? ''); ?>">
                                </div>
                                <div class="col-9">
                                    <label class="form-label">Street</label>
                                    <input type="text" class="form-control" name="street" value="<?php echo htmlspecialchars($_POST['street'] ?? ''); ?>">
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-6">
                                    <label class="form-label">City</label>
                                    <input type="text" class="form-control" name="city" value="<?php echo htmlspecialchars($_POST['city'] ?? ''); ?>">
                                </div>
                                <div class="col-3">
                                    <label class="form-label">State</label>
                                    <input type="text" class="form-control" name="state" maxlength="2" value="<?php echo htmlspecialchars($_POST['state'] ?? ''); ?>" style="text-transform: uppercase;">
                                </div>
                                <div class="col-3">
                                    <label class="form-label">Zip</label>
                                    <input type="text" class="form-control" name="zip" maxlength="10" value="<?php echo htmlspecialchars($_POST['zip'] ?? ''); ?>">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Phone</label>
                                <input type="tel" class="form-control" name="phone" placeholder="(555) 123-4567" value="<?php echo htmlspecialchars($_POST['phone'] ?? ''); ?>">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Email *</label>
                                <input type="email" class="form-control" name="email" placeholder="you@example.com" value="<?php echo htmlspecialchars($_POST['email'] ?? ''); ?>" required>
                            </div>

                            <div class="row mb-3">
                                <div class="col-6">
                                    <label class="form-label">Role</label>
                                    <select class="form-select" name="role">
                                        <option value="">Select role...</option>
                                        <?php foreach ($roles as $role): ?>
                                            <option value="<?php echo $role['role_id']; ?>" <?php echo (($_POST['role'] ?? '') == $role['role_id']) ? 'selected' : ''; ?>>
                                                <?php echo htmlspecialchars($role['role_name']); ?>
                                            </option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                                <div class="col-6">
                                    <label class="form-label">Cinema</label>
                                    <select class="form-select" name="cinema">
                                        <option value="">Select cinema...</option>
                                        <?php foreach ($cinemas as $cinema): ?>
                                            <option value="<?php echo $cinema['cinema_id']; ?>" <?php echo (($_POST['cinema'] ?? '') == $cinema['cinema_id']) ? 'selected' : ''; ?>>
                                                <?php echo htmlspecialchars($cinema['name']); ?>
                                            </option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Password *</label>
                                <input type="password" class="form-control" name="password" required>
                                <small class="text-white-50">Min 8 chars with uppercase, lowercase, number & special character</small>
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Confirm Password *</label>
                                <input type="password" class="form-control" name="confirmPassword" required>
                            </div>

                            <button type="submit" class="btn btn-primary w-100">Create Account</button>
                        </form>
                    </div>
                    <div class="auth-footer">
                        <small>Already have an account? <a href="login.php">Sign in</a></small>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="footer-spacer"></div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
