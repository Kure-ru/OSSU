import React from 'react'

const Header = ({ course }) => <h1>{course}</h1>



const Total = ({ parts }) => {
    console.log('total props', parts)
    const sum = parts.reduce((accumulator, currentValue) => accumulator + currentValue.exercises, 0)
return (
    <p style={{ fontWeight: 'bold' }}>total of {sum} exercises</p> 
)
}

const Part = ({ part }) => 
  <p>
    {part.name} {part.exercises}
  </p>

const Content = ({ parts }) => 
 <>
    {parts.map((part) => {
  return <Part key={part.id} part={part}/>
})}  
  </>

const Course = ({ course }) => {
  return (
    <div>
        <Header course={course.name} />
        <Content parts={course.parts} /> 
      <Total parts={course.parts} />
    </div>
  )
}

export default Course