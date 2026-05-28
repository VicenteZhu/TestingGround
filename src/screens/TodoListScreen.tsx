import React, {useState} from 'react';
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  FlatList,
  StyleSheet,
} from 'react-native';

interface Todo {
  id: number;
  text: string;
  completed: boolean;
}

export default function TodoListScreen() {
  const [todos, setTodos] = useState<Todo[]>([]);
  const [input, setInput] = useState('');
  let nextId = todos.length;

  const addTodo = () => {
    if (input.trim().length === 0) {
      return;
    }
    nextId += 1;
    setTodos([...todos, {id: nextId, text: input.trim(), completed: false}]);
    setInput('');
  };

  const toggleTodo = (id: number) => {
    setTodos(todos.map(t => (t.id === id ? {...t, completed: !t.completed} : t)));
  };

  const deleteTodo = (id: number) => {
    setTodos(todos.filter(t => t.id !== id));
  };

  const renderItem = ({item, index}: {item: Todo; index: number}) => (
    <View style={styles.todoItem}>
      <TouchableOpacity
        onPress={() => toggleTodo(item.id)}
        accessibilityLabel={`todoCheckbox_${index}`}
        testID={`todoCheckbox_${index}`}
        style={[
          styles.checkbox,
          item.completed && styles.checkboxChecked,
        ]}>
        {item.completed ? <Text style={styles.checkmark}>✓</Text> : null}
      </TouchableOpacity>

      <Text
        style={[styles.todoText, item.completed && styles.todoTextCompleted]}
        accessibilityLabel={`todoText_${index}`}
        testID={`todoText_${index}`}>
        {item.text}
      </Text>

      <TouchableOpacity
        onPress={() => deleteTodo(item.id)}
        accessibilityLabel={`todoDelete_${index}`}
        testID={`todoDelete_${index}`}
        style={styles.deleteButton}>
        <Text style={styles.deleteText}>✕</Text>
      </TouchableOpacity>
    </View>
  );

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Todo List</Text>

      <View style={styles.inputRow}>
        <TextInput
          style={styles.input}
          placeholder="Enter a new task..."
          value={input}
          onChangeText={setInput}
          accessibilityLabel="todoInput"
          testID="todoInput"
          onSubmitEditing={addTodo}
        />
        <TouchableOpacity
          style={styles.addButton}
          onPress={addTodo}
          accessibilityLabel="addTodoButton"
          testID="addTodoButton">
          <Text style={styles.addButtonText}>Add</Text>
        </TouchableOpacity>
      </View>

      <FlatList
        data={todos}
        keyExtractor={item => item.id.toString()}
        renderItem={renderItem}
        style={styles.list}
        accessibilityLabel="todoList"
        testID="todoList"
        ListEmptyComponent={
          <Text style={styles.emptyText}>No tasks yet</Text>
        }
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#f5f5f5',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
    color: '#333',
  },
  inputRow: {
    flexDirection: 'row',
    marginBottom: 20,
  },
  input: {
    flex: 1,
    height: 46,
    borderWidth: 1,
    borderColor: '#ddd',
    borderRadius: 8,
    paddingHorizontal: 12,
    fontSize: 16,
    backgroundColor: '#fff',
    marginRight: 10,
  },
  addButton: {
    height: 46,
    paddingHorizontal: 20,
    backgroundColor: '#007AFF',
    borderRadius: 8,
    justifyContent: 'center',
    alignItems: 'center',
  },
  addButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '600',
  },
  list: {
    flex: 1,
  },
  todoItem: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#fff',
    padding: 15,
    borderRadius: 8,
    marginBottom: 8,
    borderWidth: 1,
    borderColor: '#eee',
  },
  checkbox: {
    width: 24,
    height: 24,
    borderWidth: 2,
    borderColor: '#007AFF',
    borderRadius: 4,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  checkboxChecked: {
    backgroundColor: '#007AFF',
  },
  checkmark: {
    color: '#fff',
    fontSize: 14,
    fontWeight: 'bold',
  },
  todoText: {
    flex: 1,
    fontSize: 16,
    color: '#333',
  },
  todoTextCompleted: {
    textDecorationLine: 'line-through',
    color: '#999',
  },
  deleteButton: {
    width: 30,
    height: 30,
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 15,
    backgroundColor: '#FF3B30',
  },
  deleteText: {
    color: '#fff',
    fontSize: 14,
    fontWeight: 'bold',
  },
  emptyText: {
    textAlign: 'center',
    color: '#999',
    marginTop: 40,
    fontSize: 16,
  },
});