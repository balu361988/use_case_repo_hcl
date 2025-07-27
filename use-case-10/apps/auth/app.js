const express = require('express');
const session = require('express-session');
const bcrypt = require('bcrypt');

const app = express();
const port = 3002;

// Middleware
app.use(express.json());

app.use(session({
  secret: 'mysecretkey',
  resave: false,
  saveUninitialized: true,
  cookie: { secure: false } // set to true if using HTTPS behind ALB
}));

// Dummy user (can be replaced with DB later)
const user = {
  username: 'admin',
  passwordHash: bcrypt.hashSync('admin123', 10)
};

// Login route
app.post('/login', async (req, res) => {
  const { username, password } = req.body;
  if (username === user.username && await bcrypt.compare(password, user.passwordHash)) {
    req.session.user = username;
    return res.status(200).json({ message: 'Login successful' });
  } else {
    return res.status(401).json({ message: 'Invalid credentials' });
  }
});

// Auth check route
app.get('/check', (req, res) => {
  if (req.session.user) {
    return res.status(200).json({ message: 'Authenticated', user: req.session.user });
  } else {
    return res.status(401).json({ message: 'Not authenticated' });
  }
});

// ✅ Add ALB health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'UP', service: 'auth-service' });
});

// Start server
app.listen(port, () => {
  console.log(`✅ Auth service listening on port ${port}`);
});

