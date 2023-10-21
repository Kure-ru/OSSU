import { createSlice } from "@reduxjs/toolkit";

const notificationSlice = createSlice({
  name: "notification",
  initialState: "",
  reducers: {
    setNotification(state, action) {
      console.log(state, action);
      return action.payload;
    },
  },
});

export const showNotification = (notification, time) => {
  return (dispatch) => {
    dispatch(setNotification(notification));
    setTimeout(() => {
      dispatch(setNotification(""));
    }, time);
  };
};

export const { setNotification } = notificationSlice.actions;
export default notificationSlice.reducer;
