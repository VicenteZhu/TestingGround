import { useNavigate } from 'react-router-dom'

interface Props { onLogout: () => void }

const CARDS = [
  { to: '/todos', icon: '📋', label: 'Todo List', desc: 'Add, delete & manage tasks', color: '#1A73E8', bg: '#E8F0FE', id: 'navTodoList' },
  { to: '/form', icon: '📝', label: 'Registration Form', desc: 'Text, radio, switch & chips', color: '#E37400', bg: '#FCE8E6', id: 'navForm' },
  { to: '/calculator', icon: '🔢', label: 'Calculator', desc: 'Basic arithmetic operations', color: '#0D904F', bg: '#E6F4EA', id: 'navCalculator' },
]

export default function HomeScreen({ onLogout }: Props) {
  const navigate = useNavigate()

  const handleLogout = () => {
    onLogout()
    navigate('/')
  }

  return (
    <div style={{ minHeight: '100vh', background: '#fff', display: 'flex', flexDirection: 'column' }}>
      <div style={{ padding: '32px 24px 8px' }}>
        <h1 style={{ fontSize: 28, fontWeight: 700, color: '#202124', margin: 0 }}>Test App Dashboard</h1>
        <p style={{ fontSize: 14, color: '#5f6368', marginTop: 4 }}>Automation Testing Target</p>
      </div>

      <div style={{ flex: 1, padding: '20px 24px', display: 'flex', flexDirection: 'column', gap: 16 }}>
        {CARDS.map(card => (
          <div
            key={card.id}
            onClick={() => navigate(card.to)}
            aria-label={card.id}
            id={card.id}
            style={{
              display: 'flex', alignItems: 'center', padding: '20px 20px', borderRadius: 16,
              background: '#fff', border: '1px solid #e0e0e0', cursor: 'pointer',
              transition: 'box-shadow 0.2s, transform 0.15s',
            }}
            onMouseEnter={e => { e.currentTarget.style.boxShadow = '0 4px 24px rgba(0,0,0,0.08)'; e.currentTarget.style.transform = 'translateY(-2px)' }}
            onMouseLeave={e => { e.currentTarget.style.boxShadow = ''; e.currentTarget.style.transform = '' }}
          >
            <div style={{ width: 48, height: 48, borderRadius: 14, background: card.bg, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 22, marginRight: 16, flexShrink: 0 }}>
              {card.icon}
            </div>
            <div style={{ flex: 1 }}>
              <div style={{ fontSize: 16, fontWeight: 600, color: '#202124' }}>{card.label}</div>
              <div style={{ fontSize: 13, color: '#5f6368', marginTop: 2 }}>{card.desc}</div>
            </div>
            <span style={{ fontSize: 18, color: '#ccc' }}>→</span>
          </div>
        ))}

        <div style={{ flex: 1 }} />

        <button
          onClick={handleLogout}
          aria-label="logoutButton"
          id="logoutButton"
          style={{
            height: 50, borderRadius: 12, border: 'none', fontSize: 15, fontWeight: 600,
            cursor: 'pointer', background: '#C5221F', color: '#fff',
            transition: 'opacity 0.2s',
          }}
          onMouseEnter={e => { e.currentTarget.style.opacity = '0.9' }}
          onMouseLeave={e => { e.currentTarget.style.opacity = '1' }}
        >
          Logout
        </button>
      </div>
    </div>
  )
}