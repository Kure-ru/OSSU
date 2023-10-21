import React from "react";
import CountryDisplay from "./CountryDisplay";

const Countries = ({ countries, searchedCountry }) => {
  const filteredCountries = countries.filter((country) =>
    country.name.common.toLowerCase().includes(searchedCountry.toLowerCase())
  );
  

  const handleShow = (event) => {
    countryToDisplay = countries.find(
      (country) => country.name.common === event.target.value
    ) };

  if (filteredCountries.length > 1 && filteredCountries.length <= 10) {
    return filteredCountries.map((country) => (
      <ul>
        <li key={country.capital}>
          {country.name.common}
          <button onClick={handleShow} value={country.name.common}>
            show
          </button>
        </li>
      </ul>
    ));
  } else if (filteredCountries.length === 1) {
    return <CountryDisplay country={filteredCountries[0]} />;
  } else {
    return <p>Too many matches, specify another filter.</p>;
  }
};

export default Countries;
