import axios from "axios";

const baseUrl = "http://localhost:3001/anecdotes";

const getAll = async () => {
  const response = await axios.get(baseUrl);
  return response.data;
};

const createNew = async (content) => {
  const object = { content, votes: 0 };
  const response = await axios.post(baseUrl, object);
  return response.data;
};

const voteAnecdote = async (id) => {
  const anecdoteToChange = await axios.get(`${baseUrl}/${id}`);
  console.log(anecdoteToChange);
  const changedAnecdote = {
    ...anecdoteToChange.data,
    votes: anecdoteToChange.data.votes + 1,
  };
  console.log(changedAnecdote);
  const response = await axios.put(`${baseUrl}/${id}`, changedAnecdote);
  return response.data;
};

// eslint-disable-next-line import/no-anonymous-default-export
export default { getAll, createNew, voteAnecdote };
