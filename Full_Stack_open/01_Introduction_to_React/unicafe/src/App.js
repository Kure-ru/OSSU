import { useState } from 'react'

const Button = ({vote, text}) => (
  <button onClick = {vote}>
    {text}
  </button>
)

const StatisticLine = ({text, value}) => {

  return (

    <tr>
    <td>{text}</td> 
    <td>{value}</td>
    </tr>

  )
}

const Statistics = props => {

  const average = (props.good - props.bad) / props.all
  const positive = (props.good * 100) / props.all

  if (props.all < 1)
  {
    return (
      <>
      <h1>statistics</h1> 
      <p>No feedback given</p>
      </>
    )
  }
  else
  {
  return (
    <>
      <h1>statistics</h1> 
      <table>
        <tbody>
        <StatisticLine text='good' value={props.good}/>
      <StatisticLine text='neutral' value={props.neutral}/>
      <StatisticLine text='bad' value={props.bad}/>
      <StatisticLine text='all' value={props.all}/>
      <StatisticLine text='average' value={average}/>
      <StatisticLine text='positive' value={positive}/>
        </tbody>
      </table>
    </>
  )
  }
}


const App = () => {
  // save clicks of each button to its own state
  const [good, setGood] = useState(0)
  const [neutral, setNeutral] = useState(0)
  const [bad, setBad] = useState(0)
  const [all, setAll] = useState(0)

  const voteGood = () => {
    setGood(good + 1)
    setAll(all + 1)
  }

  const voteNeutral = () => {
    setNeutral(neutral + 1)
    setAll(all + 1)
  }

  const voteBad = () => {
    setBad(bad + 1)
    setAll(all + 1)
  }

  return (
    <div>
      <h1>give feedback</h1>
      <Button vote={voteGood} text='good'/>
      <Button vote={voteNeutral} text='neutral'/>
      <Button vote={voteBad} text='bad'/>  
     <Statistics good={good} neutral={neutral} bad={bad} all={all} />
    </div>
  )
}

export default App