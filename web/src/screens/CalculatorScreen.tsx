import { useState, useCallback } from 'react'

interface CalcButton {
  label: string
  aid: string
  style: 'digit' | 'operator' | 'clear' | 'equals'
}

const BUTTONS: CalcButton[][] = [
  [{ label: '7', aid: 'calcDigit_7', style: 'digit' }, { label: '8', aid: 'calcDigit_8', style: 'digit' }, { label: '9', aid: 'calcDigit_9', style: 'digit' }, { label: '÷', aid: 'calcDivide', style: 'operator' }],
  [{ label: '4', aid: 'calcDigit_4', style: 'digit' }, { label: '5', aid: 'calcDigit_5', style: 'digit' }, { label: '6', aid: 'calcDigit_6', style: 'digit' }, { label: '×', aid: 'calcMultiply', style: 'operator' }],
  [{ label: '1', aid: 'calcDigit_1', style: 'digit' }, { label: '2', aid: 'calcDigit_2', style: 'digit' }, { label: '3', aid: 'calcDigit_3', style: 'digit' }, { label: '-', aid: 'calcSubtract', style: 'operator' }],
  [{ label: '0', aid: 'calcDigit_0', style: 'digit' }, { label: 'C', aid: 'calcClear', style: 'clear' }, { label: '=', aid: 'calcEquals', style: 'equals' }, { label: '+', aid: 'calcAdd', style: 'operator' }],
]

const calc = (a: number, b: number, op: string): number => {
  switch (op) {
    case '+': return a + b
    case '-': return a - b
    case '×': return a * b
    case '÷': return b !== 0 ? a / b : 0
    default: return b
  }
}

interface Props { onBack: () => void }

export default function CalculatorScreen({ onBack }: Props) {
  const [display, setDisplay] = useState('0')
  const [firstOperand, setFirstOperand] = useState<number | null>(null)
  const [operator, setOperator] = useState<string | null>(null)
  const [waitingForSecond, setWaitingForSecond] = useState(false)

  const handleDigit = useCallback((digit: string) => {
    if (waitingForSecond) {
      setDisplay(digit)
      setWaitingForSecond(false)
    } else {
      setDisplay(prev => prev === '0' ? digit : prev + digit)
    }
  }, [waitingForSecond])

  const handleOperator = useCallback((op: string) => {
    const current = parseFloat(display)
    if (firstOperand === null) {
      setFirstOperand(current)
    } else if (operator) {
      const result = calc(firstOperand, current, operator)
      setDisplay(String(result))
      setFirstOperand(result)
    }
    setOperator(op)
    setWaitingForSecond(true)
  }, [display, firstOperand, operator])

  const handleEquals = useCallback(() => {
    if (firstOperand === null || operator === null) return
    const current = parseFloat(display)
    const result = calc(firstOperand, current, operator)
    setDisplay(String(result))
    setFirstOperand(null)
    setOperator(null)
    setWaitingForSecond(false)
  }, [display, firstOperand, operator])

  const handleClear = useCallback(() => {
    setDisplay('0')
    setFirstOperand(null)
    setOperator(null)
    setWaitingForSecond(false)
  }, [])

  const handlePress = useCallback((btn: CalcButton) => {
    switch (btn.style) {
      case 'digit': handleDigit(btn.label); break
      case 'operator': handleOperator(btn.label); break
      case 'equals': handleEquals(); break
      case 'clear': handleClear(); break
    }
  }, [handleDigit, handleOperator, handleEquals, handleClear])

  const styleMap: Record<string, string> = {
    digit: 'calc-digit',
    operator: 'calc-operator',
    clear: 'calc-clear',
    equals: 'calc-equals',
  }

  return (
    <div className="calc">
      <div className="navbar" style={{ background: '#2C2C2E', borderColor: '#3A3A3C' }}>
        <button className="navbar-back" onClick={() => window.location.href = '/home'} aria-label="navBack" id="navBack" style={{ color: '#FF9500' }}>← Home</button>
        <span className="navbar-title" style={{ color: '#fff' }}>Calculator</span>
      </div>
      <div className="calc-display">
        <span className="calc-display-text" aria-label="calcDisplay" id="calcDisplay">{display}</span>
      </div>
      <div className="calc-keypad">
        {BUTTONS.map((row, ri) => (
          <div key={ri} className="calc-row">
            {row.map(btn => (
              <button key={btn.aid} className={`calc-btn ${styleMap[btn.style]}`} onClick={() => handlePress(btn)} aria-label={btn.aid} id={btn.aid}>
                {btn.label}
              </button>
            ))}
          </div>
        ))}
      </div>
    </div>
  )
}