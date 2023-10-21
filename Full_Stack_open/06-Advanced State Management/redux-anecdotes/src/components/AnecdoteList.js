import React from "react";
import { useSelector, useDispatch } from "react-redux";
import { voteAnecdote } from "../reducers/anecdoteReducer";
import { setNotification } from "../reducers/notificationReducer";

const AnecdoteList = () => {
  const dispatch = useDispatch();
  const anecdotes = useSelector((state) => {
    if (state.filter === "") {
      console.log(state.anecdotes);
      return state.anecdotes;
    }
    return state.anecdotes.filter((anecdote) =>
      anecdote.content.includes(state.filter)
    );
  });
  const sortedAnecdotes = [...anecdotes].sort((a, b) => b.votes - a.votes);

  const vote = (id, anecdote) => {
    dispatch(voteAnecdote(id));
    dispatch(setNotification(`you voted '${anecdote}' !`));
    setTimeout(() => {
      dispatch(setNotification(""));
    }, 5000);
  };

  return (
    <div>
      {sortedAnecdotes
        .sort((a, b) => b.votes - a.votes)
        .map((anecdote) => (
          <div key={anecdote.id}>
            <div>{anecdote.content}</div>
            <div>
              has {anecdote.votes}
              <button onClick={() => vote(anecdote.id, anecdote.content)}>
                vote
              </button>
            </div>
          </div>
        ))}
    </div>
  );
};

export default AnecdoteList;
