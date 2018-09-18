window.onload = () => {
    enableEducationNewsFeed();
};
document.addEventListener("turbolinks:load", () => {
    trackSection();
    enableTableSortAndSearch();
    document.getElementById("resultsCount").innerHTML = `${document.getElementsByTagName("tbody")[0].children.length} records found.`;
});


let trackSection = () => {
    for (let x = 0; x < document.getElementsByClassName("sideMenuItem").length; x++) {
        if (document.getElementsByClassName("sideMenuItem")[x].firstElementChild.href.split("/")[3] === window.location.pathname.split("/")[1]) {
            document.getElementsByClassName("sideMenuItem")[x].style.backgroundColor = "black";
        }
    }
}

let enableTableSortAndSearch = () => {
    let sortOptions = {
        valueNames: []
    };
    for (let x = 0; x < document.getElementsByTagName("tr")[0].children.length-1; x++) {
        sortOptions.valueNames.push(document.getElementsByTagName("tr")[0].children[x].getAttribute("data-sort"));
        console.log(document.getElementsByTagName("tr")[0].children[x].getAttribute("data-sort"));
    }
    let tableList = new List("main", sortOptions);
    if (document.getElementById("filterBy") != null) {
        let filterType = document.getElementById("filterBy").classList[0].slice(0,document.getElementById("filterBy").classList[0].lastIndexOf("-"));
        console.log(filterType);
        document.getElementById("filterBy").addEventListener("change", (event)=>{
            let currentFilter = document.getElementById("filterBy").value;
            console.log(currentFilter)
            if (currentFilter === "all") {
                tableList.filter();
                return; 
            }
            tableList.filter((row)=>{
                if (row.values()[filterType].replace("<h4>", "").replace("</h4>", "") === currentFilter) {
                    return true;
                }
                else {
                    return false;
                }
            });
        });
    }
    tableList.on("searchComplete", ()=>{
        document.getElementById("resultsCount").innerText = `${tableList.matchingItems.length} records found.`;
    });
    tableList.on("filterComplete", ()=>{
        document.getElementById("resultsCount").innerText = `${tableList.matchingItems.length} records found.`;
    });
    for (let x = 0; x < document.getElementsByTagName("tr")[0].children.length-1; x++) {
        document.getElementsByTagName("tr")[0].children[x].addEventListener("click", (event)=>{
            for (let y = 0; y < document.getElementsByTagName("tr")[0].children.length-1; y++) {
                if (document.getElementsByTagName("tr")[0].children[y] != document.getElementsByTagName("tr")[0].children[x]) {
                    document.getElementsByTagName("tr")[0].children[y].firstElementChild.innerHTML = document.getElementsByTagName("tr")[0].children[y].firstElementChild.innerHTML.replace(" <span>▲</span>", "").replace(" <span>▼</span>", "");
                }
                else {
                    if (document.getElementsByTagName("tr")[0].children[y].firstElementChild.innerHTML.slice(-8) === "▲</span>") {
                        document.getElementsByTagName("tr")[0].children[y].firstElementChild.innerHTML = document.getElementsByTagName("tr")[0].children[y].firstElementChild.innerHTML.replace(" <span>▲</span>", " <span>▼</span>");
                    }
                    else if (document.getElementsByTagName("tr")[0].children[y].firstElementChild.innerHTML.slice(-8) === "▼</span>") {
                        document.getElementsByTagName("tr")[0].children[y].firstElementChild.innerHTML = document.getElementsByTagName("tr")[0].children[y].firstElementChild.innerHTML.replace(" <span>▼</span>", " <span>▲</span>");

                    }
                    else {
                        document.getElementsByTagName("tr")[0].children[y].firstElementChild.innerHTML = document.getElementsByTagName("tr")[0].children[y].firstElementChild.innerHTML + " <span>▲</span>";
                    }
                }
            }
        });
    }
}
let enableEducationNewsFeed = () => {
    let apiKEY = "b8f597b75fc5474f924f70782809910d";
    let today = new Date();
    axios.get(`https://newsapi.org/v2/everything?q="culinary institute"&from=${today.getFullYear()}-${today.getMonth()+1}-${today.getDate()}&sortBy=relevancy&apiKey=${apiKEY}`)
    .then((response) => {
        console.log(response);
        let postIndex = 0;
        setInterval(()=> {
            let currentPost = response.data.articles[postIndex];
            let currentPostTitle = currentPost.title;
            let currentPostSource = currentPost.source.name;
            if (currentPostTitle.length > 80) {
                currentPostTitle = currentPost.title.slice(0, 80) + "...";
            }
            if (currentPostSource.length > 80) {
                currentPostSource = currentPostSource.slice(0, 80) + "...";
            }
            document.getElementById("newsfeed").innerHTML = `${currentPostSource}: <a href = "${currentPost.url}">${currentPostTitle}</a>`;
            postIndex++;
            if (postIndex === response.data.articles.length-1) {
                postIndex = 0;
            }
        }, 4000);
    })
    .catch((error) => {
      console.log(error);
    });
}







