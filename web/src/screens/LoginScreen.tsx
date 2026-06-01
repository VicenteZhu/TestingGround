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

function FloatingIcon({ icon, style }: { icon: string; style: React.CSSProperties }) {
  const duration = 12 + Math.random() * 10
  return (
    <span
      style={{
        position: 'absolute',
        fontSize: `${20 + Math.random() * 24}px`,
        opacity: 0.08,
        pointerEvents: 'none',
        userSelect: 'none',
        zIndex: 0,
        animation: `float ${duration}s infinite ease-in-out`,
        animationDelay: `${Math.random() * -20}s`,
        ...style,
      }}>
      {icon}
    </span>
  )
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
    <div style={{ minHeight: '100vh', background: '#fff', display: 'flex', alignItems: 'center', justifyContent: 'center', position: 'relative', overflow: 'hidden' }}>
      <style>{`
        @keyframes float {
          0%, 100% { transform: translateY(0) rotate(0deg); }
          25% { transform: translateY(-30px) rotate(5deg); }
          50% { transform: translateY(-15px) rotate(-3deg); }
          75% { transform: translateY(-40px) rotate(2deg); }
        }
        @keyframes fadeInUp {
          from { opacity: 0; transform: translateY(12px); }
          to { opacity: 1; transform: translateY(0); }
        }
        @keyframes shine {
          0% { background-position: 200% center; }
          100% { background-position: -200% center; }
        }
      `}</style>
      {icons.map((ico, i) => (
        <FloatingIcon key={i} icon={ico} style={{ left: `${8 + (i * 12) % 85}%`, top: `${5 + (i * 17) % 80}%` }} />
      ))}
      <div style={{ position: 'relative', zIndex: 1, width: '100%', maxWidth: 380, padding: '0 24px' }}>
        <div style={{ textAlign: 'center', marginBottom: 48, animation: 'fadeInUp 0.6s ease-out' }}>
          <div style={{
            width: 72, height: 72, borderRadius: 20, margin: '0 auto 24px',
            background: gradient, display: 'flex', alignItems: 'center', justifyContent: 'center',
            boxShadow: '0 8px 32px rgba(0,0,0,0.12)',
          }}>
            <span style={{ fontSize: 32 }}>🧪</span>
          </div>
          <h1 style={{ fontSize: 32, fontWeight: 700, color: '#202124', margin: 0, letterSpacing: '-0.5px' }}>TestingGround</h1>
          <p style={{ fontSize: 14, color: '#5f6368', marginTop: 8 }}>Automation Testing Target</p>
        </div>

        <div style={{ display: 'flex', flexDirection: 'column', gap: 12, animation: 'fadeInUp 0.6s ease-out 0.15s', animationFillMode: 'both' }}>
          <div style={{
            display: 'flex', alignItems: 'center', background: '#f1f3f4', borderRadius: 12,
            padding: '4px 16px', transition: 'background 0.2s, box-shadow 0.2s',
            ...(focused === 'username' ? { background: '#e8f0fe', boxShadow: '0 0 0 2px #1A73E8' } : {}),
          }}>
            <span style={{ fontSize: 18, marginRight: 12, opacity: 0.5 }}>👤</span>
            <input
              style={{ flex: 1, height: 52, border: 'none', background: 'transparent', fontSize: 16, color: '#202124', outline: 'none' }}
              placeholder="Username"
              value={username}
              onChange={e => { setUsername(e.target.value); setError('') }}
              onFocus={() => setFocused('username')}
              onBlur={() => setFocused(null)}
              onKeyDown={handleKeyDown}
              autoCapitalize="none"
              aria-label="usernameInput"
              id="usernameInput"
            />
          </div>

          <div style={{
            display: 'flex', alignItems: 'center', background: '#f1f3f4', borderRadius: 12,
            padding: '4px 16px', transition: 'background 0.2s, box-shadow 0.2s',
            ...(focused === 'password' ? { background: '#e8f0fe', boxShadow: '0 0 0 2px #1A73E8' } : {}),
          }}>
            <span style={{ fontSize: 18, marginRight: 12, opacity: 0.5 }}>🔒</span>
            <input
              type="password"
              style={{ flex: 1, height: 52, border: 'none', background: 'transparent', fontSize: 16, color: '#202124', outline: 'none' }}
              placeholder="Password"
              value={password}
              onChange={e => { setPassword(e.target.value); setError('') }}
              onFocus={() => setFocused('password')}
              onBlur={() => setFocused(null)}
              onKeyDown={handleKeyDown}
              aria-label="passwordInput"
              id="passwordInput"
            />
          </div>

          {error ? (
            <p style={{ color: '#C5221F', fontSize: 13, margin: 0, paddingLeft: 4 }} aria-label="loginError" id="loginError">{error}</p>
          ) : null}

          <button
            onClick={handleLogin}
            style={{
              height: 52, borderRadius: 12, border: 'none', fontSize: 16, fontWeight: 600,
              cursor: 'pointer', marginTop: 4, position: 'relative', overflow: 'hidden',
              background: gradient,
              backgroundSize: '200% auto',
              animation: 'shine 4s linear infinite',
              color: '#fff', letterSpacing: '0.3px',
              boxShadow: '0 2px 12px rgba(0,0,0,0.15)',
              transition: 'transform 0.15s, box-shadow 0.15s',
            }}
            onMouseEnter={e => { (e.target as HTMLButtonElement).style.transform = 'translateY(-1px)'; (e.target as HTMLButtonElement).style.boxShadow = '0 4px 20px rgba(0,0,0,0.2)' }}
            onMouseLeave={e => { (e.target as HTMLButtonElement).style.transform = ''; (e.target as HTMLButtonElement).style.boxShadow = '0 2px 12px rgba(0,0,0,0.15)' }}
            aria-label="loginButton"
            id="loginButton"
          >
            Sign in
          </button>
        </div>

        <p style={{ textAlign: 'center', marginTop: 32, fontSize: 12, color: '#9aa0a6' }}>
          Built-in credentials · admin / 123456
        </p>
      </div>
    </div>
  )
}