import React from "react";

const CountryDisplay = ({ country }) => {
    
    console.log('display', country)
    
    return (
  <div>
    <h1>{country.name.common}</h1>
    <p>Capital: {country.capital}</p>
    <p>Area: {country.area}</p>
    <h2>languages</h2>
    {Object.values(country.languages).map((language) => (
      <ul>
        <li key={country.capital}>{language}</li>
      </ul>
    ))}
    <img src={country.flags.png} alt="flag"></img>
  </div>
);}

export default CountryDisplay;
