// import axios from "axios";
import { useState, useEffect } from "react";
import countryService from "./services/countries";
import Countries from "./components/Countries";
import Filter from "./components/Filter";
import CountryDisplay from "./components/CountryDisplay";

const App = () => {

  useEffect(() => {
    countryService.getAll().then((response) => {
      setCountries(response.data);
    });
  }, []);

  const [countries, setCountries] = useState([]);
  const [searchedCountry, setSearch] = useState("");

  const handleSearch = (event) => {setSearch(event.target.value)}

  return(
    <div>
     <Filter searchedCountry={searchedCountry} handleSearch={handleSearch}/>
      <Countries countries={countries} searchedCountry={searchedCountry}/>
    </div>
  )

}
 
export default App;

