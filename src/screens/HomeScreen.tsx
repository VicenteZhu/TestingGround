import React, {useCallback} from 'react';
import {View, Text, Pressable, StyleSheet} from 'react-native';

import {ScreenProps} from '../navigation/AppNavigator';

export default function HomeScreen({navigation}: ScreenProps<'Home'>) {
  const handleLogout = useCallback(() => {
    navigation.replace('Login');
  }, [navigation]);

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Test App Dashboard</Text>
      <Text style={styles.subtitle}>Automation Testing Target</Text>

      <View style={styles.menuContainer}>
        <Pressable
          style={styles.menuButton}
          onPress={() => navigation.navigate('TodoList')}
          accessibilityLabel="navTodoList"
          testID="navTodoList">
          <Text style={styles.menuButtonText}>📋 Todo List</Text>
        </Pressable>

        <Pressable
          style={styles.menuButton}
          onPress={() => navigation.navigate('Form')}
          accessibilityLabel="navForm"
          testID="navForm">
          <Text style={styles.menuButtonText}>📝 Form</Text>
        </Pressable>

        <Pressable
          style={styles.menuButton}
          onPress={() => navigation.navigate('Calculator')}
          accessibilityLabel="navCalculator"
          testID="navCalculator">
          <Text style={styles.menuButtonText}>🔢 Calculator</Text>
        </Pressable>
      </View>

      <Pressable
        style={styles.logoutButton}
        onPress={handleLogout}
        accessibilityLabel="logoutButton"
        testID="logoutButton">
        <Text style={styles.logoutText}>Logout</Text>
      </Pressable>
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
    fontSize: 26,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 5,
  },
  subtitle: {
    fontSize: 14,
    color: '#888',
    marginBottom: 40,
  },
  menuContainer: {
    width: '100%',
    gap: 15,
  },
  menuButton: {
    width: '100%',
    height: 60,
    backgroundColor: '#fff',
    borderRadius: 10,
    justifyContent: 'center',
    alignItems: 'center',
    borderWidth: 1,
    borderColor: '#ddd',
  },
  menuButtonText: {
    fontSize: 18,
    fontWeight: '500',
    color: '#333',
  },
  logoutButton: {
    marginTop: 40,
    paddingVertical: 12,
    paddingHorizontal: 30,
    backgroundColor: '#FF3B30',
    borderRadius: 8,
  },
  logoutText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '600',
  },
});