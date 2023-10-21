import AnecdoteForm from "./components/AnecdoteForm";
import Notification from "./components/Notification";
import { useQuery, useMutation, useQueryClient } from "react-query";
import { getAnecdotes, updateVote } from "./requests";
import { useNotificationDispatch } from "./NotificationContext";

const App = () => {
  const queryClient = useQueryClient();
  const dispatch = useNotificationDispatch();

  const updateVoteMutation = useMutation(updateVote, {
    onSuccess: (updatedAnecdote) => {
      queryClient.setQueryData("anecdotes", (prev) =>
        prev.map((anecdote) =>
          anecdote.id === updatedAnecdote.id ? updatedAnecdote : anecdote
        )
      );
    },
  });

  const { isLoading, isError, data } = useQuery("anecdotes", getAnecdotes, {
    retry: 1,
    onError: (error) => {
      console.error("An error occurred while fetching anecdotes:", error);
    },
  });

  const handleVote = async (anecdote) => {
    if (!anecdote.id) {
      console.error("anecdote id not found");
      return;
    }
    const updatedAnecdote = { ...anecdote, votes: anecdote.votes + 1 };
    updateVoteMutation.mutate(updatedAnecdote);
    await dispatch({
      type: "SET_NOTIFICATION",
      payload: `you voted '${anecdote.content}'`,
    });
    setTimeout(() => {
      dispatch({ ype: "CLEAR_NOTIFICATION" });
    }, 5000);

    console.log("vote");
  };

  if (isLoading) {
    return <div>loading data...</div>;
  }

  if (isError) {
    return <div>anecdote service not avaiable due to problems in server</div>;
  }

  return (
    <div>
      <h3>Anecdote app</h3>

      <Notification />
      <AnecdoteForm />

      {data.map((anecdote) => (
        <div key={anecdote.id}>
          <div>{anecdote.content}</div>
          <div>
            has {anecdote.votes}
            <button onClick={() => handleVote(anecdote)}>vote</button>
          </div>
        </div>
      ))}
    </div>
  );
};

export default App;
