import { useState } from 'react'
import { useNavigate } from 'react-router-dom'

const COUNTRIES = ['China', 'United States', 'Japan', 'Germany', 'Other']

interface Props { onBack: () => void }

export default function FormScreen({ onBack }: Props) {
  const [name, setName] = useState('')
  const [email, setEmail] = useState('')
  const [gender, setGender] = useState('')
  const [subscribed, setSubscribed] = useState(false)
  const [country, setCountry] = useState('')
  const [showResult, setShowResult] = useState(false)
  const navigate = useNavigate()

  const handleSubmit = () => {
    setShowResult(true)
  }

  return (
    <div style={{ minHeight: '100vh', display: 'flex', flexDirection: 'column', background: '#f5f5f5' }}>
      <div className="navbar">
        <button className="navbar-back" onClick={() => navigate('/home')} aria-label="navBack" id="navBack">← Home</button>
        <span className="navbar-title">Registration Form</span>
      </div>

      <div className="page-body">
        <div style={{ maxWidth: 400 }}>
          <p className="label">Name</p>
          <input className="input" style={{ maxWidth: '100%' }} placeholder="Enter your name" value={name} onChange={e => { setName(e.target.value); setShowResult(false) }} aria-label="nameInput" id="nameInput" />

          <p className="label">Email</p>
          <input className="input" style={{ maxWidth: '100%' }} placeholder="Enter your email" value={email} onChange={e => { setEmail(e.target.value); setShowResult(false) }} aria-label="emailInput" id="emailInput" />

          <p className="label">Gender</p>
          <div className="radio-group">
            <div className="radio-item" onClick={() => { setGender('Male'); setShowResult(false) }} aria-label="genderRadioMale" id="genderRadioMale">
              <div className={`radio-outer ${gender === 'Male' ? 'selected' : ''}`}>{gender === 'Male' ? <div className="radio-inner" /> : null}</div>
              <span>Male</span>
            </div>
            <div className="radio-item" onClick={() => { setGender('Female'); setShowResult(false) }} aria-label="genderRadioFemale" id="genderRadioFemale">
              <div className={`radio-outer ${gender === 'Female' ? 'selected' : ''}`}>{gender === 'Female' ? <div className="radio-inner" /> : null}</div>
              <span>Female</span>
            </div>
          </div>

          <div className="switch-row" style={{ marginTop: 16 }}>
            <p className="label" style={{ margin: 0 }}>Subscribe to newsletter</p>
            <label style={{ position: 'relative', display: 'inline-block', width: 48, height: 28, cursor: 'pointer' }}>
              <input type="checkbox" checked={subscribed} onChange={e => { setSubscribed(e.target.checked); setShowResult(false) }} style={{ opacity: 0, width: 0, height: 0 }} aria-label="subscribeSwitch" id="subscribeSwitch" />
              <span style={{ position: 'absolute', inset: 0, background: subscribed ? '#34C759' : '#ccc', borderRadius: 14, transition: '0.3s' }} />
              <span style={{ position: 'absolute', width: 22, height: 22, borderRadius: '50%', background: '#fff', top: 3, left: subscribed ? 23 : 3, transition: '0.3s', boxShadow: '0 1px 3px rgba(0,0,0,0.2)' }} />
            </label>
          </div>

          <p className="label">Country</p>
          <div className="chip-row">
            {COUNTRIES.map(c => (
              <div key={c} className={`chip ${country === c ? 'selected' : ''}`} onClick={() => { setCountry(c); setShowResult(false) }} aria-label={`country_${c.replace(/\s+/g, '')}`} id={`country_${c.replace(/\s+/g, '')}`}>
                {c}
              </div>
            ))}
          </div>

          <button className="btn btn-success" style={{ maxWidth: '100%', marginTop: 10 }} onClick={handleSubmit} aria-label="submitButton" id="submitButton">Submit</button>

          {showResult ? (
            <div className="result-box" aria-label="formResult" id="formResult" style={{ maxWidth: '100%' }}>
              <p className="result-title">Submitted Data:</p>
              <p className="result-text">Name: {name || '-'}</p>
              <p className="result-text">Email: {email || '-'}</p>
              <p className="result-text">Gender: {gender || '-'}</p>
              <p className="result-text">Subscribed: {subscribed ? 'Yes' : 'No'}</p>
              <p className="result-text">Country: {country || '-'}</p>
            </div>
          ) : null}
        </div>
      </div>
    </div>
  )
}