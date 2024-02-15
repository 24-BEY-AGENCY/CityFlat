// authSlice.js

import { createSlice } from '@reduxjs/toolkit';

const initialState = {
  user: null,
  isAuthenticated: false,
  isLoading: false, // Add isLoading state
};

const authSlice = createSlice({
  name: 'auth',
  initialState,
  reducers: {
    login(state, action) {
      state.isLoading = true; // Set loading state to true when logging in
      state.user = action.payload;
      state.isAuthenticated = true;
      state.isLoading = false; // Set loading state back to false after login
    },
    logout(state) {
      state.isLoading = true; // Set loading state to true when logging out
      state.user = null;
      state.isAuthenticated = false;
      state.isLoading = false; // Set loading state back to false after logout
    },
  },
});

export const { login, logout } = authSlice.actions;
export default authSlice.reducer;
