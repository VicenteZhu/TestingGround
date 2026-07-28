import React, {useState, useCallback} from 'react';
import {
  View,
  Text,
  TextInput,
  Pressable,
  StyleSheet,
} from 'react-native';

import {ScreenProps} from '../navigation/AppNavigator';

export default function LoginScreen({navigation}: ScreenProps<'Login'>) {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');

  const handleLogin = useCallback(() => {
    if (username === 'admin' && password === '123456') {
      setError('');
      navigation.replace('Home');
    } else {
      setError('Invalid username or password');
    }
  }, [navigation, username, password]);

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Login</Text>

      <TextInput
        style={styles.input}
        placeholder="Username"
        value={username}
        onChangeText={text => {
          setUsername(text);
          setError('');
        }}
        accessibilityLabel="usernameInput"
        testID="usernameInput"
        autoCapitalize="none"
      />

      <TextInput
        style={styles.input}
        placeholder="Password"
        value={password}
        onChangeText={text => {
          setPassword(text);
          setError('');
        }}
        secureTextEntry
        accessibilityLabel="passwordInput"
        testID="passwordInput"
      />

      <Pressable
        style={styles.button}
        onPress={handleLogin}
        accessibilityLabel="loginButton"
        testID="loginButton">
        <Text style={styles.buttonText}>Login</Text>
      </Pressable>

      {error ? (
        <Text
          style={styles.error}
          accessibilityLabel="loginError"
          testID="loginError">
          {error}
        </Text>
      ) : null}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
    backgroundColor: '#f5f5f5',
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    marginBottom: 40,
    color: '#333',
  },
  input: {
    width: '100%',
    height: 50,
    borderWidth: 1,
    borderColor: '#ddd',
    borderRadius: 8,
    paddingHorizontal: 15,
    marginBottom: 15,
    fontSize: 16,
    backgroundColor: '#fff',
  },
  button: {
    width: '100%',
    height: 50,
    backgroundColor: '#007AFF',
    borderRadius: 8,
    justifyContent: 'center',
    alignItems: 'center',
    marginTop: 10,
  },
  buttonText: {
    color: '#fff',
    fontSize: 18,
    fontWeight: '600',
  },
  error: {
    color: 'red',
    marginTop: 15,
    fontSize: 14,
  },
});