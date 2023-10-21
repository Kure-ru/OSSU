const Header = (course) => {
  return (
      <h1>{course.course}</h1>
  )
}

const Content = (props) => {
  return (
    <>
   <Part part={props.parts[0]} />
   <Part part={props.parts[1]} />
   <Part part={props.parts[2]} />
   </>
  )
}

const Part = (part) => {
  return (
   <p>
    {part.part.name} {part.part.exercises}
  </p>

  )
}

const Total = (parts) => {
  console.log()
  return (
    <>
    <p>Number of exercises {parts.parts[0].exercises + parts.parts[1].exercises + parts.parts[2].exercises}</p>
    </>
  )
}


const App = () => {
  const course = {
    name: 'Half Stack application development',
    parts: [
      {
        name: 'Fundamentals of React',
        exercises: 10
      },
      {
        name: 'Using props to pass data',
        exercises: 7
      },
      {
        name: 'State of a component',
        exercises: 14
      }
    ]
  }

  return (
    <div>
      <Header course={course.name} />
      <Content parts={course.parts} />
      <Total parts={course.parts}/> 
    </div>
  )
}


export default App