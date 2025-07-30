# Testing Guide - Empower Health & Wealth App

## 🧪 Authentication Flow & Database Testing

This guide will help you test the complete authentication flow and database setup for the Empower Health & Wealth App.

## ✅ Pre-Testing Checklist

### 1. **Supabase Project Setup**
- [ ] Supabase project created at [supabase.com](https://supabase.com)
- [ ] Database schema executed from `supabase_setup.md`
- [ ] Row Level Security policies enabled
- [ ] Sample data inserted (achievements, learning modules)

### 2. **App Configuration**
- [ ] Supabase URL and anon key updated in `lib/config/supabase_config.dart`
- [ ] Flutter dependencies installed (`flutter pub get`)
- [ ] App builds and runs without errors

## 🔍 Testing Scenarios

### **Scenario 1: Initial App Launch**

**Expected Behavior:**
- App should launch and show the Login Screen
- Supabase initialization should complete (check console logs)
- UI should display with modern design and proper fonts

**Test Steps:**
1. Run `flutter run`
2. Verify app launches successfully
3. Check console for "Supabase init completed" message
4. Confirm Login Screen is displayed

**✅ Pass Criteria:**
- [ ] App launches without errors
- [ ] Login screen displays correctly
- [ ] Supabase connection established
- [ ] Modern UI with Satoshi font visible

---

### **Scenario 2: User Registration Flow**

**Expected Behavior:**
- User can create new account
- Email verification is sent
- Profile is automatically created in database

**Test Steps:**
1. Tap "Create Account" on Login Screen
2. Fill in registration form:
   - Full Name: "Test User"
   - Email: Use a real email you can access
   - Password: "TestPass123!"
   - Confirm Password: "TestPass123!"
3. Accept terms and conditions
4. Tap "Create Account"
5. Check email for verification link
6. Verify profile creation in Supabase dashboard

**✅ Pass Criteria:**
- [ ] Registration form validates correctly
- [ ] Account creation succeeds
- [ ] Verification email received
- [ ] Profile record created in `profiles` table
- [ ] Success message displayed
- [ ] Redirected back to Login Screen

---

### **Scenario 3: Email Verification**

**Expected Behavior:**
- User receives verification email
- Clicking link verifies account
- User can now sign in

**Test Steps:**
1. Check email inbox for verification message
2. Click verification link
3. Confirm account is verified in Supabase Auth dashboard
4. Return to app and attempt login

**✅ Pass Criteria:**
- [ ] Verification email received
- [ ] Email link works correctly
- [ ] Account marked as verified in Supabase
- [ ] Can proceed with login

---

### **Scenario 4: User Login Flow**

**Expected Behavior:**
- User can sign in with verified credentials
- Authentication state is managed correctly
- User is redirected to appropriate screen

**Test Steps:**
1. Enter verified email and password
2. Tap "Sign In"
3. Observe navigation flow
4. Check if user has completed onboarding

**✅ Pass Criteria:**
- [ ] Login succeeds with correct credentials
- [ ] Login fails with incorrect credentials
- [ ] Appropriate error messages displayed
- [ ] Navigation works correctly (Onboarding or Dashboard)

---

### **Scenario 5: Onboarding Flow**

**Expected Behavior:**
- New users see onboarding screens
- Profile data is collected and saved
- Goals are created in database
- User is redirected to dashboard

**Test Steps:**
1. Complete onboarding steps:
   - **Step 1**: Enter name, age, city
   - **Step 2**: Select 1-2 primary goals
   - **Step 3**: Set specific health and wealth goals
   - **Step 4**: Choose experience level
2. Tap "Start My Journey"
3. Verify data is saved to database
4. Confirm navigation to dashboard

**✅ Pass Criteria:**
- [ ] All onboarding steps work correctly
- [ ] Form validation functions properly
- [ ] Profile data saved to `profiles` table
- [ ] Health goal created in `health_goals` table
- [ ] Wealth goal created in `wealth_goals` table
- [ ] Navigation to dashboard succeeds

---

### **Scenario 6: Dashboard Data Loading**

**Expected Behavior:**
- Dashboard loads user profile data
- Stats display correctly (XP, level, streak)
- UI components render properly

**Test Steps:**
1. Verify dashboard displays user name
2. Check stats cards show correct values
3. Confirm all UI components load
4. Test sign out functionality

**✅ Pass Criteria:**
- [ ] User name displays correctly
- [ ] Stats show appropriate values
- [ ] All dashboard components render
- [ ] Sign out works and returns to login

---

### **Scenario 7: Database Verification**

**Expected Behavior:**
- All database operations work correctly
- Row Level Security prevents unauthorized access
- Data integrity is maintained

**Test Steps:**
1. Open Supabase dashboard
2. Navigate to Table Editor
3. Verify data in tables:
   - `profiles`: User profile exists
   - `health_goals`: Health goal created
   - `wealth_goals`: Wealth goal created
   - `achievements`: Sample achievements present
   - `learning_modules`: Sample modules present
4. Test RLS by trying to access another user's data

**✅ Pass Criteria:**
- [ ] Profile data correctly stored
- [ ] Goals created with proper user association
- [ ] Sample data (achievements, modules) present
- [ ] RLS prevents cross-user data access
- [ ] All foreign key relationships work

---

### **Scenario 8: Error Handling**

**Expected Behavior:**
- App handles errors gracefully
- Appropriate error messages shown
- App doesn't crash on network issues

**Test Steps:**
1. Test with invalid email format
2. Test with weak password
3. Test with mismatched password confirmation
4. Test login with non-existent account
5. Test with network disconnected

**✅ Pass Criteria:**
- [ ] Form validation shows helpful messages
- [ ] Authentication errors handled properly
- [ ] Network errors handled gracefully
- [ ] App remains stable during errors

---

## 🔧 Troubleshooting

### **Common Issues & Solutions**

#### **Issue: Supabase Connection Failed**
- **Check**: Verify URL and anon key in `SupabaseConfig`
- **Check**: Ensure Supabase project is active
- **Solution**: Update credentials and restart app

#### **Issue: Email Verification Not Received**
- **Check**: Spam/junk folder
- **Check**: Email settings in Supabase Auth
- **Solution**: Configure SMTP settings in Supabase

#### **Issue: Database Errors**
- **Check**: RLS policies are correctly set up
- **Check**: Tables exist with proper schema
- **Solution**: Re-run database setup from `supabase_setup.md`

#### **Issue: Profile Not Created**
- **Check**: Database trigger `handle_new_user` exists
- **Check**: Trigger is enabled and functioning
- **Solution**: Manually create profile or fix trigger

#### **Issue: UI Not Loading Correctly**
- **Check**: Font files are properly included
- **Check**: Theme configuration is correct
- **Solution**: Run `flutter clean && flutter pub get`

---

## 📊 Testing Checklist Summary

### **Authentication Testing**
- [ ] App launches successfully
- [ ] Registration flow works end-to-end
- [ ] Email verification functions
- [ ] Login/logout works correctly
- [ ] Error handling is appropriate

### **Database Testing**
- [ ] Profile creation automatic
- [ ] Goals are saved correctly
- [ ] RLS policies work
- [ ] Sample data is present
- [ ] Data relationships intact

### **UI/UX Testing**
- [ ] Modern design displays correctly
- [ ] Fonts load properly
- [ ] Navigation flows smoothly
- [ ] Forms validate appropriately
- [ ] Responsive design works

### **Integration Testing**
- [ ] Onboarding saves to database
- [ ] Dashboard loads real data
- [ ] Authentication state persists
- [ ] Real-time updates work
- [ ] Error recovery functions

---

## 🎯 Success Criteria

The app passes testing when:

1. **✅ Complete Authentication Flow**: Users can register, verify email, and sign in
2. **✅ Database Integration**: All data operations work with proper security
3. **✅ UI/UX Excellence**: Modern design displays correctly across devices
4. **✅ Error Resilience**: App handles errors gracefully without crashes
5. **✅ Data Persistence**: User data is properly saved and retrieved

---

## 📝 Test Results Template

```
## Test Results - [Date]

### Authentication Flow: ✅ PASS / ❌ FAIL
- Registration: ✅ PASS / ❌ FAIL
- Email Verification: ✅ PASS / ❌ FAIL  
- Login: ✅ PASS / ❌ FAIL
- Logout: ✅ PASS / ❌ FAIL

### Database Operations: ✅ PASS / ❌ FAIL
- Profile Creation: ✅ PASS / ❌ FAIL
- Goal Creation: ✅ PASS / ❌ FAIL
- Data Loading: ✅ PASS / ❌ FAIL
- RLS Security: ✅ PASS / ❌ FAIL

### UI/UX: ✅ PASS / ❌ FAIL
- Design System: ✅ PASS / ❌ FAIL
- Navigation: ✅ PASS / ❌ FAIL
- Forms: ✅ PASS / ❌ FAIL
- Responsiveness: ✅ PASS / ❌ FAIL

### Notes:
[Add any issues found or observations]
```

---

**Ready to test? Start with Scenario 1 and work through each scenario systematically!** 🚀