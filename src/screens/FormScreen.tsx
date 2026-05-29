import React, {useState, useCallback} from 'react';
import {
  View,
  Text,
  TextInput,
  Pressable,
  Switch,
  ScrollView,
  StyleSheet,
} from 'react-native';

const COUNTRIES = ['China', 'United States', 'Japan', 'Germany', 'Other'];

export default function FormScreen() {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [gender, setGender] = useState('');
  const [subscribed, setSubscribed] = useState(false);
  const [country, setCountry] = useState('');
  const [showResult, setShowResult] = useState(false);

  const handleSubmit = useCallback(() => {
    setShowResult(true);
  }, []);

  return (
    <ScrollView style={styles.container} contentContainerStyle={styles.content}>
      <Text style={styles.title}>Registration Form</Text>

      {/* Name */}
      <Text style={styles.label}>Name</Text>
      <TextInput
        style={styles.input}
        placeholder="Enter your name"
        value={name}
        onChangeText={t => {
          setName(t);
          setShowResult(false);
        }}
        accessibilityLabel="nameInput"
        testID="nameInput"
      />

      {/* Email */}
      <Text style={styles.label}>Email</Text>
      <TextInput
        style={styles.input}
        placeholder="Enter your email"
        value={email}
        onChangeText={t => {
          setEmail(t);
          setShowResult(false);
        }}
        keyboardType="email-address"
        autoCapitalize="none"
        accessibilityLabel="emailInput"
        testID="emailInput"
      />

      {/* Gender */}
      <Text style={styles.label}>Gender</Text>
      <View style={styles.radioGroup}>
        <Pressable
          style={styles.radioItem}
          onPress={() => {
            setGender('Male');
            setShowResult(false);
          }}
          accessibilityLabel="genderRadioMale"
          testID="genderRadioMale">
          <View
            style={[
              styles.radioOuter,
              gender === 'Male' && styles.radioOuterSelected,
            ]}>
            {gender === 'Male' && <View style={styles.radioInner} />}
          </View>
          <Text style={styles.radioLabel}>Male</Text>
        </Pressable>

        <Pressable
          style={styles.radioItem}
          onPress={() => {
            setGender('Female');
            setShowResult(false);
          }}
          accessibilityLabel="genderRadioFemale"
          testID="genderRadioFemale">
          <View
            style={[
              styles.radioOuter,
              gender === 'Female' && styles.radioOuterSelected,
            ]}>
            {gender === 'Female' && <View style={styles.radioInner} />}
          </View>
          <Text style={styles.radioLabel}>Female</Text>
        </Pressable>
      </View>

      {/* Subscribe Switch */}
      <View style={styles.switchRow}>
        <Text style={styles.label}>Subscribe to newsletter</Text>
        <Switch
          value={subscribed}
          onValueChange={v => {
            setSubscribed(v);
            setShowResult(false);
          }}
          accessibilityLabel="subscribeSwitch"
          testID="subscribeSwitch"
        />
      </View>

      {/* Country */}
      <Text style={styles.label}>Country</Text>
      <View style={styles.countryGroup}>
        {COUNTRIES.map(c => (
          <Pressable
            key={c}
            style={[
              styles.countryChip,
              country === c && styles.countryChipSelected,
            ]}
            onPress={() => {
              setCountry(c);
              setShowResult(false);
            }}
            accessibilityLabel={`country_${c.replace(/\s+/g, '')}`}
            testID={`country_${c.replace(/\s+/g, '')}`}>
            <Text
              style={[
                styles.countryChipText,
                country === c && styles.countryChipTextSelected,
              ]}>
              {c}
            </Text>
</Pressable>
        ))}
      </View>

      {/* Submit */}
      <Pressable
        style={styles.submitButton}
        onPress={handleSubmit}
        accessibilityLabel="submitButton"
        testID="submitButton">
        <Text style={styles.submitButtonText}>Submit</Text>
      </Pressable>

      {/* Result */}
      {showResult ? (
        <View style={styles.result} accessibilityLabel="formResult" testID="formResult">
          <Text style={styles.resultTitle}>Submitted Data:</Text>
          <Text style={styles.resultText}>Name: {name || '-'}</Text>
          <Text style={styles.resultText}>Email: {email || '-'}</Text>
          <Text style={styles.resultText}>Gender: {gender || '-'}</Text>
          <Text style={styles.resultText}>
            Subscribed: {subscribed ? 'Yes' : 'No'}
          </Text>
          <Text style={styles.resultText}>Country: {country || '-'}</Text>
        </View>
      ) : null}
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  content: {
    padding: 20,
    paddingBottom: 40,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
    color: '#333',
  },
  label: {
    fontSize: 14,
    fontWeight: '600',
    color: '#555',
    marginBottom: 6,
    marginTop: 12,
  },
  input: {
    height: 46,
    borderWidth: 1,
    borderColor: '#ddd',
    borderRadius: 8,
    paddingHorizontal: 12,
    fontSize: 16,
    backgroundColor: '#fff',
  },
  radioGroup: {
    flexDirection: 'row',
    gap: 30,
  },
  radioItem: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  radioOuter: {
    width: 22,
    height: 22,
    borderRadius: 11,
    borderWidth: 2,
    borderColor: '#007AFF',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 8,
  },
  radioOuterSelected: {
    borderColor: '#007AFF',
  },
  radioInner: {
    width: 12,
    height: 12,
    borderRadius: 6,
    backgroundColor: '#007AFF',
  },
  radioLabel: {
    fontSize: 16,
    color: '#333',
  },
  switchRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  countryGroup: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
    marginBottom: 20,
  },
  countryChip: {
    paddingHorizontal: 14,
    paddingVertical: 8,
    borderRadius: 20,
    borderWidth: 1,
    borderColor: '#ddd',
    backgroundColor: '#fff',
  },
  countryChipSelected: {
    borderColor: '#007AFF',
    backgroundColor: '#007AFF',
  },
  countryChipText: {
    fontSize: 14,
    color: '#333',
  },
  countryChipTextSelected: {
    color: '#fff',
  },
  submitButton: {
    height: 50,
    backgroundColor: '#34C759',
    borderRadius: 8,
    justifyContent: 'center',
    alignItems: 'center',
    marginTop: 10,
  },
  submitButtonText: {
    color: '#fff',
    fontSize: 18,
    fontWeight: '600',
  },
  result: {
    marginTop: 20,
    padding: 15,
    backgroundColor: '#fff',
    borderRadius: 8,
    borderWidth: 1,
    borderColor: '#ddd',
  },
  resultTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 8,
    color: '#333',
  },
  resultText: {
    fontSize: 14,
    color: '#555',
    marginBottom: 4,
  },
});