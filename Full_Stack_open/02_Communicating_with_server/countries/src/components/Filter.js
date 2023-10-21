import React from "react";

const Filter = ({ searchedCountry, handleSearch }) => {

return (
<form>
<label>find countries</label>
<input onChange={handleSearch} value={searchedCountry}/>
</form>
)

}

export default Filter;