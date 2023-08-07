import React from 'react';
import { Route, Routes } from 'react-router-dom';
import { CampaignDetails, CreateCampaign, Home, Profile } from './pages';
import { Navbar, Sidebar } from './components';

const App = () => {
    return (
        <div className="relative sm:-8 p-4 bg-[#13131a] min-h-screen flex flex-row" style={{ backgroundColor: '#000000', height: '100vh' }}>
            <div>
                <Sidebar />
            </div>
            <div>
                <Navbar />
                <Routes>
                    <Route path="/" element={<Home />} />
                </Routes>
            </div>
        </div>
    );
};

export default App;
