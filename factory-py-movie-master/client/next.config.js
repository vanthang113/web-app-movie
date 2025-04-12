/** @type {import('next').NextConfig} */
const nextConfig = {
    reactStrictMode: true,
    webpack: (config, { isServer }) => {
        if (!isServer) {
            config.resolve.fallback = {
                ...config.resolve.fallback,
                fs: false,
                net: false,
                tls: false,
                dns: false,
                child_process: false,
                readline: false,
            };
        }
        return config;
    },
    env: {
        "BASE_URL": "http://localhost:8000"
    }
};

module.exports = nextConfig;