window.lessonPaths = [
  "/lessons/select-from/",
  "/lessons/limit/",
  "/lessons/where-and-comparison-operators/",
  "/lessons/like/",
  "/lessons/like/",
  "/lessons/between/",
  "/lessons/is-null/",
  "/lessons/and/",
  "/lessons/or/",
  "/lessons/not/",
  "/lessons/order-by/",
  "/lessons/offset/",
  "/lessons/case-when/",
  "/lessons/common-aggregation-functions/",
  "/lessons/group-by/",
  "/lessons/having/",
  "/lessons/distinct/",
  "/lessons/main-data-types-and-type-conversion/",
  "/lessons/numbers/",
  "/lessons/strings/",
  "/lessons/regular-expressions/",
  "/lessons/dates-and-times/",
  "/lessons/null-values/",
  "/lessons/record/",
  "/lessons/arrays/",
  "/lessons/subqueries-and-common-table-expressions/",
  "/lessons/cross-join/",
  "/lessons/inner-join/",
  "/lessons/left-join-and-right-join/",
  "/lessons/full-outer-join/",
  "/lessons/self-join/",
  "/lessons/union-and-union-all/",
  "/lessons/user-defined-functions/",
  "/lessons/table-functions/",
  "/lessons/views/",
  "/lessons/recursive-queries/",
  "/lessons/aggregate-window-functions/",
  "/lessons/row-number/",
  "/lessons/ntile/",
  "/lessons/rank/",
  "/lessons/dense-rank/",
  "/lessons/lag/",
  "/lessons/lead/",
  "/lessons/first-value/",
  "/lessons/last-value/",
  "/lessons/nth-value/",
  "/lessons/percent-rank/",
  "/lessons/pivot/"
];

function sha512(str) {
  return crypto.subtle.digest("SHA-512", new TextEncoder("utf-8").encode(str)).then(buf => {
    return Array.prototype.map.call(new Uint8Array(buf), x=>(('00'+x.toString(16)).slice(-2))).join('');
  });
}

function goToSample(event) {
  event.preventDefault();
  localStorage.setItem("sampleCredit", 1);
  let samplePath = window.lessonPaths[Math.round(Math.random() * window.lessonPaths.length)];
  window.location.href = samplePath + '?sample=true';
}

function redirectToHomeIfNotSample() {
  displayProspectNavigation();
  if (!document.location.pathname.includes("/lessons/")) {
    return;
  }
  if (document.location.href.includes("sample=true") && parseInt(localStorage.getItem("sampleCredit")) === 1) {
    localStorage.setItem("sampleCredit", 0);
    return;
  }
  window.location.href = "/";
}

function displayProspectNavigation() {
  document.querySelector(".login").style.display = "inline";
  document.querySelector(".logout").style.display = "none";
  if (document.location.pathname === "/") {
    document.querySelectorAll(".table-of-contents a").forEach(function(link) {
      if (!(link.classList && link.classList.toString().includes("see-sample"))) {
        link.removeAttribute("href");
      }
    });
  }
  if (document.location.pathname.includes("/lessons/")) {
    document.querySelector(".prospect-lesson-navigation").style.display = "block";
    document.querySelector(".customer-lesson-navigation").style.display = "none";
  }
}

function displayCustomerNavigation() {
  document.querySelector(".login").style.display = "none";
  document.querySelectorAll(".see-sample").forEach(function(item) {
    item.style.display = "none";
  });
  document.querySelector(".logout").style.display = "block";
  if (document.location.pathname.includes("/lessons/")) {
    document.querySelector(".prospect-lesson-navigation").style.display = "none";
    document.querySelector(".customer-lesson-navigation").style.display = "block";
  }
}

function authorizeCustomerId(customerId) {
  let spreadsheetId = '114HO1SHQE2BeRNB-yp8oxCrcTxz1zktbbCMD2fx9A-I';
  let tabName = 'Sheet1';
  let apiKey = 'AIzaSyDA-3vkJBHtZgKYgaoAddqAiJ4XVpMApMY';
  let url = 'https://sheets.googleapis.com/v4/spreadsheets/' + spreadsheetId + '/values/' + tabName + '?alt=json&key=' + apiKey;
  fetch(url, {
    method: 'GET',
    headers: { 'Accept': 'application/json' }
  })
  .then(response => response.json())
  .then((response) => {
    let customerIds = response.values.slice(1).map(x => x[0]);
    if ((customerIds).includes(customerId)) {
      displayCustomerNavigation();
    }
    else {
      redirectToHomeIfNotSample();
    }
  });
}

const firebaseConfig = {
  apiKey: "AIzaSyCSEBtSL0CHhMsJA955PlGkz7dUqDKzbAo",
  authDomain: "sql-boss.firebaseapp.com",
  projectId: "sql-boss",
  storageBucket: "sql-boss.appspot.com",
  messagingSenderId: "264513429608",
  appId: "1:264513429608:web:fe4e1c73a2ef16aad61bdd",
};

const firebaseApp = firebase.initializeApp(firebaseConfig);
window.firebaseApp = firebaseApp;

// Initialize the FirebaseUI Widget using Firebase.
var ui = new firebaseui.auth.AuthUI(firebaseApp.auth());
var uiConfig = {
  signInOptions: [
    {
      provider: firebase.auth.EmailAuthProvider.PROVIDER_ID,
      signInMethod: firebase.auth.EmailAuthProvider.EMAIL_LINK_SIGN_IN_METHOD
    },
  ],
  signInFlow: 'popup',
  signInSuccessUrl: (window.location.hostname === 'localhost') ? 'http://localhost:4000' : 'https://sqlboss.co/'
};


window.onload = function(event) {

  document.querySelector("body").addEventListener("click", function(event) {
    let firebasePopup = document.querySelector("#firebaseui-auth-container");
    if (firebasePopup.clientHeight > 0) {
      document.querySelector("#firebaseui-auth-container").style.display = "none";
    }
  });

  document.querySelectorAll(".see-sample").forEach(function(item) {
    item.addEventListener("click", function(e) {
      e.preventDefault();
      goToSample(e);
    });
  });

  document.querySelector(".login").addEventListener("click", function(event) {
    event.preventDefault();
    event.stopPropagation();
    if (document.querySelector("#firebaseui-auth-container").style.display === "none") {
      document.querySelector("#firebaseui-auth-container").style.display = "block";
    }
    else {
      ui.start('#firebaseui-auth-container', uiConfig);
    }
  });

  document.querySelector("#firebaseui-auth-container").addEventListener("click", function(event) {
    event.stopPropagation();
  });

  document.querySelector(".logout").addEventListener("click", function(event) {
    event.preventDefault();
    firebaseApp.auth().signOut().then(() => {
      document.location.href = "/";
    }).catch((error) => {
      alert("Sorry, an error occured");
    });
  });

  if (firebaseApp.auth().isSignInWithEmailLink(window.location.href)) {
    ui.start('#firebaseui-auth-container', uiConfig);
  }

  firebaseApp.auth().onAuthStateChanged((user) => {
    if (user) {
      sha512(user.email).then((customerId) => {
        authorizeCustomerId(customerId);
      });
    } else {
      redirectToHomeIfNotSample();
    }
  });
};
