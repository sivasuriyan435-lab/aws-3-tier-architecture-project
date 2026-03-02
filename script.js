document.getElementById("loginButton").addEventListener("click", async () => {
    // 🔧 Backend API URL (replace with your ALB DNS)
    const backendURL = "http://BackendLB-url.com/login";

    const responseText = document.getElementById("response");
    responseText.innerText = "⏳ Fetching user...";

    try {
        const response = await fetch(backendURL, {
            method: "GET",
            headers: {
                "Content-Type": "application/json"
            }
        });

        if (!response.ok) {
            throw new Error(`HTTP error: ${response.status}`);
        }

        const data = await response.json();

        if (data.username && data.email) {
            responseText.innerText =
                `✅ User: ${data.username} | Email: ${data.email}`;
        } else {
            responseText.innerText = "⚠️ No user data found!";
        }

    } catch (error) {
        console.error("Error fetching data:", error);
        responseText.innerText = "❌ Failed to load data!";
    }
});
