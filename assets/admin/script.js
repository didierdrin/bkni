
import { initializeApp } from "https://www.gstatic.com/firebasejs/10.6.0/firebase-app.js";
import { getFirestore, collection, getDocs, addDoc, deleteDoc } from "https://www.gstatic.com/firebasejs/10.6.0/firebase-firestore.js";

// console.log("Here is a sample!");

const firebaseConfig = {
    // Your Firebase configuration here.
    apiKey: "AIzaSyBxU9tcwP4Jf52jDYcHdHfzyukw0h1nKRE",
    authDomain: "bukoni-6b0b3.firebaseapp.com",
    projectId: "bukoni-6b0b3",
    storageBucket: "bukoni-6b0b3.appspot.com",
    messagingSenderId: "306097629999",
    appId: "1:306097629999:web:e537b7ade7f32fade48fda",
    measurementId: "G-HRBRLEBECY"
}; 

// initialize the db
const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

// access the db collection
const getFirestoreData = async () => {
    const querySnapshot = await getDocs(collection(db, "sales"));

    querySnapshot.forEach((doc) => {
        const salesDataDiv = document.getElementById("salesData");
    
       
            // doc.data() is never undefined for query doc snapshots
            const data = doc.data();
            
            // Create a new div for each document.
            const div = document.createElement("div");
            div.className = "p-4 border rounded shadow";
            div.innerHTML = `
                <h2 class="text-xl">${data['name']}</h2>
                <p>Quantity Sold: ${data["quantity"]}</p>
                <p>Total Revenue: ${data["revenue"]}</p>
                <div>
                <button class="delete px-3 py-1 bg-green-500 hover:bg-green-700 text-white">Confirm</button>
                <button class="delete px-3 py-1 bg-red-500 hover:bg-red-700 text-white">Refund</button>
                </div>
                `;
            
            document.querySelectorAll('.delete').forEach(function(button) {
                button.addEventListener('click', function(event) {
                    var item = event.target.parentElement;
                    item.parentElement.removeChild(item);
                }); });
        
            // Append the new div to the "salesData" div.
            salesDataDiv.appendChild(div);
    
        
    });// log each doc
}

const getFirestoreInventoryData = async () => {
    const querySnapshot = await getDocs(collection(db, "inventory"));

    querySnapshot.forEach((doc) => {
        const salesDataDiv = document.getElementById("inventoryData");
    
       
            // doc.data() is never undefined for query doc snapshots
            const data = doc.data();
            
            // Create a new div for each document.
            const div = document.createElement("div");
            div.className = "p-4 border rounded shadow";
            div.innerHTML = `
                <h2 class="text-xl">${data['name']}</h2>
                <p>Size: ${data["size"]}</p>
                <p>Price: ${data["price"]}</p>
                <button class="delete px-3 py-1 bg-blue-500 hover:bg-blue-700 text-white">Delete</button>
                `;

            document.querySelectorAll('.delete').forEach(function(button) {
                button.addEventListener('click', async function(event) {
                    var item = event.target.parentElement;
                    item.parentElement.removeChild(item);
                    // Delete the document from firestore
                    await deleteDoc(doc(db, "inventory", doc.id));
                }); });
        
            // Append the new div to the "salesData" div.
            salesDataDiv.appendChild(div);
    
        
    });// log each doc
}

getFirestoreData();
getFirestoreInventoryData();

submitData.addEventListener("click", (e) => {
    var name = document.getElementById("name").value; 
    var color = document.getElementById("color").value;
    var quantity = document.getElementById("quantity").value; 
    var size = document.getElementById("size").value; 
    var price = document.getElementById("price").value; 
    var product_id = document.getElementById("product_id").value; 
    var img_url = document.getElementById("img_url").value;
    var description = document.getElementById("description").value; 

    addDoc(collection(db, "inventory"), {
        name: name,
        color: color, 
        quantity: quantity, 
        size: size, 
        price: price, 
        product_id: product_id, 
        img_url: img_url, 
        description: description,
    });
    
    alert("Product Added");
});



/*

import { initializeApp } from "https://www.gstatic.com/firebasejs/10.6.0/firebase-app.js";
import { getFirestore, collection, getDocs } from "https://www.gstatic.com/firebasejs/10.6.0/firebase-firestore.js";

const firebaseConfig = {
    // Your Firebase configuration here.
    apiKey: "AIzaSyBxU9tcwP4Jf52jDYcHdHfzyukw0h1nKRE",
    authDomain: "bukoni-6b0b3.firebaseapp.com",
    projectId: "bukoni-6b0b3",
    storageBucket: "bukoni-6b0b3.appspot.com",
    messagingSenderId: "306097629999",
    appId: "1:306097629999:web:e537b7ade7f32fade48fda",
    measurementId: "G-HRBRLEBECY"
}; */
