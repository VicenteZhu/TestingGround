import React, {useState} from 'react';
import {View, Text, TouchableOpacity, StyleSheet} from 'react-native';

interface CalcButton {
  label: string;
  a11yLabel: string;
  style: 'digit' | 'operator' | 'clear' | 'equals';
}

export default function CalculatorScreen() {
  const [display, setDisplay] = useState('0');
  const [firstOperand, setFirstOperand] = useState<number | null>(null);
  const [operator, setOperator] = useState<string | null>(null);
  const [waitingForSecond, setWaitingForSecond] = useState(false);

  const handleDigit = (digit: string) => {
    if (waitingForSecond) {
      setDisplay(digit);
      setWaitingForSecond(false);
    } else {
      setDisplay(display === '0' ? digit : display + digit);
    }
  };

  const handleOperator = (op: string) => {
    const current = parseFloat(display);
    if (firstOperand === null) {
      setFirstOperand(current);
    } else if (operator) {
      const result = calculate(firstOperand, current, operator);
      setDisplay(String(result));
      setFirstOperand(result);
    }
    setOperator(op);
    setWaitingForSecond(true);
  };

  const calculate = (a: number, b: number, op: string): number => {
    switch (op) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '×':
        return a * b;
      case '÷':
        return b !== 0 ? a / b : 0;
      default:
        return b;
    }
  };

  const handleEquals = () => {
    if (firstOperand === null || operator === null) {
      return;
    }
    const current = parseFloat(display);
    const result = calculate(firstOperand, current, operator);
    setDisplay(String(result));
    setFirstOperand(null);
    setOperator(null);
    setWaitingForSecond(false);
  };

  const handleClear = () => {
    setDisplay('0');
    setFirstOperand(null);
    setOperator(null);
    setWaitingForSecond(false);
  };

  const buttons: CalcButton[][] = [
    [
      {label: '7', a11yLabel: 'calcDigit_7', style: 'digit'},
      {label: '8', a11yLabel: 'calcDigit_8', style: 'digit'},
      {label: '9', a11yLabel: 'calcDigit_9', style: 'digit'},
      {label: '÷', a11yLabel: 'calcDivide', style: 'operator'},
    ],
    [
      {label: '4', a11yLabel: 'calcDigit_4', style: 'digit'},
      {label: '5', a11yLabel: 'calcDigit_5', style: 'digit'},
      {label: '6', a11yLabel: 'calcDigit_6', style: 'digit'},
      {label: '×', a11yLabel: 'calcMultiply', style: 'operator'},
    ],
    [
      {label: '1', a11yLabel: 'calcDigit_1', style: 'digit'},
      {label: '2', a11yLabel: 'calcDigit_2', style: 'digit'},
      {label: '3', a11yLabel: 'calcDigit_3', style: 'digit'},
      {label: '-', a11yLabel: 'calcSubtract', style: 'operator'},
    ],
    [
      {label: '0', a11yLabel: 'calcDigit_0', style: 'digit'},
      {label: 'C', a11yLabel: 'calcClear', style: 'clear'},
      {label: '=', a11yLabel: 'calcEquals', style: 'equals'},
      {label: '+', a11yLabel: 'calcAdd', style: 'operator'},
    ],
  ];

  const getButtonStyle = (type: string) => {
    switch (type) {
      case 'digit':
        return styles.digitButton;
      case 'operator':
        return styles.operatorButton;
      case 'clear':
        return styles.clearButton;
      case 'equals':
        return styles.equalsButton;
      default:
        return styles.digitButton;
    }
  };

  const getButtonTextStyle = (type: string) => {
    switch (type) {
      case 'operator':
        return styles.operatorText;
      case 'clear':
        return styles.clearText;
      case 'equals':
        return styles.equalsText;
      default:
        return styles.digitText;
    }
  };

  const handlePress = (btn: CalcButton) => {
    switch (btn.style) {
      case 'digit':
        handleDigit(btn.label);
        break;
      case 'operator':
        handleOperator(btn.label);
        break;
      case 'equals':
        handleEquals();
        break;
      case 'clear':
        handleClear();
        break;
    }
  };

  return (
    <View style={styles.container}>
      <View style={styles.display}>
        <Text
          style={styles.displayText}
          numberOfLines={1}
          adjustsFontSizeToFit
          accessibilityLabel="calcDisplay"
          testID="calcDisplay">
          {display}
        </Text>
      </View>

      <View style={styles.keypad}>
        {buttons.map((row, ri) => (
          <View key={ri} style={styles.row}>
            {row.map(btn => (
              <TouchableOpacity
                key={btn.a11yLabel}
                style={[styles.button, getButtonStyle(btn.style)]}
                onPress={() => handlePress(btn)}
                accessibilityLabel={btn.a11yLabel}
                testID={btn.a11yLabel}>
                <Text style={[styles.buttonText, getButtonTextStyle(btn.style)]}>
                  {btn.label}
                </Text>
              </TouchableOpacity>
            ))}
          </View>
        ))}
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#1C1C1E',
  },
  display: {
    flex: 2,
    justifyContent: 'flex-end',
    alignItems: 'flex-end',
    padding: 20,
  },
  displayText: {
    color: '#fff',
    fontSize: 64,
    fontWeight: '300',
  },
  keypad: {
    flex: 5,
    padding: 10,
  },
  row: {
    flex: 1,
    flexDirection: 'row',
  },
  button: {
    flex: 1,
    margin: 6,
    borderRadius: 12,
    justifyContent: 'center',
    alignItems: 'center',
  },
  buttonText: {
    fontSize: 28,
    fontWeight: '400',
  },
  digitButton: {
    backgroundColor: '#505050',
  },
  digitText: {
    color: '#fff',
  },
  operatorButton: {
    backgroundColor: '#FF9500',
  },
  operatorText: {
    color: '#fff',
  },
  clearButton: {
    backgroundColor: '#D4D4D2',
  },
  clearText: {
    color: '#000',
  },
  equalsButton: {
    backgroundColor: '#FF9500',
  },
  equalsText: {
    color: '#fff',
  },
});