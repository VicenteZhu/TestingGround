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
    <div className="home-screen">
      <div className="home-header">
        <h1 className="home-title">Test App Dashboard</h1>
        <p className="home-subtitle">Automation Testing Target</p>
      </div>

      <div className="home-body">
        {CARDS.map(card => (
          <div
            key={card.id}
            className="home-card"
            onClick={() => navigate(card.to)}
            aria-label={card.id}
            id={card.id}
          >
            <div className="home-card-icon" style={{ background: card.bg }}>{card.icon}</div>
            <div className="home-card-body">
              <div className="home-card-title">{card.label}</div>
              <div className="home-card-desc">{card.desc}</div>
            </div>
            <span className="home-card-arrow">→</span>
          </div>
        ))}

        <div style={{ flex: 1 }} />

        <button
          className="btn btn-danger"
          onClick={handleLogout}
          aria-label="logoutButton"
          id="logoutButton"
        >
          Logout
        </button>
      </div>
    </div>
  )
}
