import { useState } from 'react'
import { useNavigate } from 'react-router-dom'

interface Props { onLogin: () => void }

const AUTOFOCUS_COLORS = ['#1A73E8', '#E37400', '#0D904F', '#C5221F', '#7B1FA2', '#F9AB00']

function getRandomColor() {
  return AUTOFOCUS_COLORS[Math.floor(Math.random() * AUTOFOCUS_COLORS.length)]
}

function getGoogleStyleGradient() {
  const c1 = getRandomColor()
  let c2 = getRandomColor()
  while (c2 === c1) c2 = getRandomColor()
  return `linear-gradient(135deg, ${c1}, ${c2})`
}

const techIcons = ['💡', '🎯', '🚀', '⚡', '🔮', '🌟', '💎', '🔥', '🧪', '🛡️']

function getRandomIcons(count: number) {
  const shuffled = [...techIcons].sort(() => Math.random() - 0.5)
  return shuffled.slice(0, count)
}

interface FloatingIconProps {
  icon: string
  style: React.CSSProperties
}

function FloatingIcon({ icon, style }: FloatingIconProps) {
  return <span className="login-floating-icon" style={style}>{icon}</span>
}

export default function LoginScreen({ onLogin }: Props) {
  const [username, setUsername] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [focused, setFocused] = useState<'username' | 'password' | null>(null)
  const navigate = useNavigate()
  const [gradient] = useState(getGoogleStyleGradient)
  const [icons] = useState(() => getRandomIcons(8))

  const handleLogin = () => {
    if (username === 'admin' && password === '123456') {
      setError('')
      onLogin()
      navigate('/home')
    } else {
      setError('Invalid username or password')
    }
  }

  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter') handleLogin()
  }

  return (
    <div className="login-page">
      {icons.map((ico, i) => (
        <FloatingIcon
          key={i}
          icon={ico}
          style={{ left: `${8 + (i * 12) % 85}%`, top: `${5 + (i * 17) % 80}%` }}
        />
      ))}
      <div className="login-box">
        <div className="login-header">
          <div className="login-logo" style={{ background: gradient }}>
            <span>🧪</span>
          </div>
          <h1 className="login-title">TestingGround</h1>
          <p className="login-subtitle">Automation Testing Target</p>
        </div>

        <div className="login-form">
          <div className={`login-input-wrap${focused === 'username' ? ' login-input-wrap--focused' : ''}`}>
            <span className="login-input-icon">👤</span>
            <input
              className="login-input"
              placeholder="Username"
              value={username}
              onChange={e => { setUsername((e.target as HTMLInputElement).value); setError('') }}
              onFocus={() => setFocused('username')}
              onBlur={() => setFocused(null)}
              onKeyDown={handleKeyDown}
              autoCapitalize="none"
              aria-label="usernameInput"
              id="usernameInput"
            />
          </div>

          <div className={`login-input-wrap${focused === 'password' ? ' login-input-wrap--focused' : ''}`}>
            <span className="login-input-icon">🔒</span>
            <input
              type="password"
              className="login-input"
              placeholder="Password"
              value={password}
              onChange={e => { setPassword((e.target as HTMLInputElement).value); setError('') }}
              onFocus={() => setFocused('password')}
              onBlur={() => setFocused(null)}
              onKeyDown={handleKeyDown}
              aria-label="passwordInput"
              id="passwordInput"
            />
          </div>

          {error ? (
            <p className="login-error" aria-label="loginError" id="loginError">{error}</p>
          ) : null}

          <button
            className="login-btn"
            onClick={handleLogin}
            style={{ background: gradient }}
            aria-label="loginButton"
            id="loginButton"
          >
            Sign in
          </button>
        </div>

        <p className="login-hint">
          Built-in credentials · admin / 123456
        </p>
      </div>
    </div>
  )
}
