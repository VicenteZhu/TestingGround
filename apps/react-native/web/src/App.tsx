import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom'
import { useState } from 'react'
import LoginScreen from './screens/LoginScreen'
import HomeScreen from './screens/HomeScreen'
import TodoListScreen from './screens/TodoListScreen'
import FormScreen from './screens/FormScreen'
import CalculatorScreen from './screens/CalculatorScreen'

export default function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false)

  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<LoginScreen onLogin={() => setIsLoggedIn(true)} />} />
        <Route path="/home" element={isLoggedIn ? <HomeScreen onLogout={() => setIsLoggedIn(false)} /> : <Navigate to="/" />} />
        <Route path="/todos" element={isLoggedIn ? <TodoListScreen onBack={() => {}} /> : <Navigate to="/" />} />
        <Route path="/form" element={isLoggedIn ? <FormScreen onBack={() => {}} /> : <Navigate to="/" />} />
        <Route path="/calculator" element={isLoggedIn ? <CalculatorScreen onBack={() => {}} /> : <Navigate to="/" />} />
      </Routes>
    </BrowserRouter>
  )
}