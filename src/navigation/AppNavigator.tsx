import React from 'react';
import {NavigationContainer} from '@react-navigation/native';
import {createNativeStackNavigator} from '@react-navigation/native-stack';
import LoginScreen from '../screens/LoginScreen';
import HomeScreen from '../screens/HomeScreen';
import TodoListScreen from '../screens/TodoListScreen';
import FormScreen from '../screens/FormScreen';
import CalculatorScreen from '../screens/CalculatorScreen';

const Stack = createNativeStackNavigator();

export default function AppNavigator() {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="Login">
        <Stack.Screen
          name="Login"
          component={LoginScreen}
          options={{headerShown: false}}
        />
        <Stack.Screen
          name="Home"
          component={HomeScreen}
          options={{headerShown: false}}
        />
        <Stack.Screen
          name="TodoList"
          component={TodoListScreen}
          options={{title: 'Todo List'}}
        />
        <Stack.Screen
          name="Form"
          component={FormScreen}
          options={{title: 'Registration Form'}}
        />
        <Stack.Screen
          name="Calculator"
          component={CalculatorScreen}
          options={{title: 'Calculator'}}
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
}