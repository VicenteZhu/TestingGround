import { useState, useRef, useCallback, memo } from 'react'
import { useNavigate } from 'react-router-dom'

interface Todo {
  id: number
  text: string
  completed: boolean
}

interface Props { onBack: () => void }

interface TodoItemProps {
  item: Todo
  index: number
  onToggle: (id: number) => void
  onDelete: (id: number) => void
}

const TodoItemInner = ({ item, index, onToggle, onDelete }: TodoItemProps) => {
  return (
    <div className="todo-item">
      <div
        className={`checkbox${item.completed ? ' checked' : ''}`}
        onClick={() => onToggle(item.id)}
        aria-label={`todoCheckbox_${index}`}
        id={`todoCheckbox_${index}`}
      >
        {item.completed ? <span className="checkmark">✓</span> : null}
      </div>
      <span className={`todo-text${item.completed ? ' done' : ''}`} aria-label={`todoText_${index}`} id={`todoText_${index}`}>
        {item.text}
      </span>
      <button className="todo-delete" onClick={() => onDelete(item.id)} aria-label={`todoDelete_${index}`} id={`todoDelete_${index}`}>
        ✕
      </button>
    </div>
  )
}

const TodoItem = memo(TodoItemInner)
TodoItem.displayName = 'TodoItem'

export default function TodoListScreen({ onBack }: Props) {
  const [todos, setTodos] = useState<Todo[]>([])
  const [input, setInput] = useState('')
  const nextId = useRef(0)
  const navigate = useNavigate()

  const addTodo = useCallback(() => {
    if (input.trim().length === 0) return
    nextId.current += 1
    setTodos(prev => [...prev, { id: nextId.current, text: input.trim(), completed: false }])
    setInput('')
  }, [input])

  const toggleTodo = useCallback((id: number) => {
    setTodos(prev => prev.map(t => t.id === id ? { ...t, completed: !t.completed } : t))
  }, [])

  const deleteTodo = useCallback((id: number) => {
    setTodos(prev => prev.filter(t => t.id !== id))
  }, [])

  return (
    <div className="todo-screen">
      <div className="navbar">
        <button className="navbar-back" onClick={() => navigate('/home')} aria-label="navBack" id="navBack">← Home</button>
        <span className="navbar-title">Todo List</span>
      </div>

      <div className="todo-body">
        <div className="todo-input-row">
          <input
            className="input"
            placeholder="Enter a new task..."
            value={input}
            onChange={e => setInput((e.target as HTMLInputElement).value)}
            onKeyDown={e => { if (e.key === 'Enter') addTodo() }}
            aria-label="todoInput"
            id="todoInput"
          />
          <button className="btn btn-primary" onClick={addTodo} aria-label="addTodoButton" id="addTodoButton">Add</button>
        </div>

        <div className="todo-list" aria-label="todoList" id="todoList">
          {todos.length === 0 ? (
            <p className="empty-text">No tasks yet</p>
          ) : (
            todos.map((item, index) => (
              <TodoItem key={item.id} item={item} index={index} onToggle={toggleTodo} onDelete={deleteTodo} />
            ))
          )}
        </div>
      </div>
    </div>
  )
}
