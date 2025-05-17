fetch('http://backend:5000/info')
    .then(response => response.json())
    .then(data => {
        document.getElementById('hostname').textContent = data.hostname;
        document.getElementById('ip').textContent = data.ip_address;
    })
    .catch(error => console.error('Error fetching data:', error));
