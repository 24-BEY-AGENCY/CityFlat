import "./App.css";
import "bootstrap/dist/css/bootstrap.css";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Details from "./pages/Details/Details";
import Home from "./pages/Home/Home";
import Dashboard from "./pages/Dashboard/Dashboard";
import Profile from "./pages/Profile/Profile";
import Navbar from "./components/navbar/Navbar";
import Footer from "./components/footer/Footer";
import { useEffect } from "react";

function App() {
  const Layout = ({ children }) => {
    return (
      <div>
        <Navbar />
        <div>{children}</div>
        {/* <Footer /> */}
      </div>
    );
  };

  return (
    <>
      {/* <Home/> */}
      {/* <Details /> */}
      {/* <Dashboard/> */}
      {/* <Profile /> */}
      <Router>
        <Routes>
          <Route
            path="/"
            element={
              <Layout>
                <Home />
              </Layout>
            }
          />
          <Route
            path="/details/:id"
            element={
              <Layout>
                <Details />
              </Layout>
            }
          />
          <Route path="/dashboard" element={<Dashboard />} />
          <Route
            path="/profil"
            element={
              <Layout>
                <Profile />
              </Layout>
            }
          />
        </Routes>
      </Router>
    </>
  );
}

export default App;
