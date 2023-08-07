import './globals.css'
import { Inter } from 'next/font/google'
import Navbar from '@/components/Navbar'
import { siteConfig } from "@/config/site"
import Sidebar from '@/components/Sidebar'
const inter = Inter({ subsets: ['latin'] })
import Icon from '@/components/Icon'
import Provider from '@/components/Provider'
export const metadata = {
  title: {
    default: siteConfig.name,
    template: `%s | ${siteConfig.name}`,
  },
  description: siteConfig.description,
  keywords: [
    "Web3",
    "Dapps",
    "React",
    "Nextjs",
    "Thirdweb",
 
  ],
  authors: [
    {
      name: "Rozales",
      url: "https://openai-article-summarizer-mu.vercel.app",
    },
  ],
  creator: "Rozales",
  openGraph: {
    type: "website",
    locale: "en_US",
    url: siteConfig.url,
    title: siteConfig.name,
    description: siteConfig.description,
    siteName: siteConfig.name,
  },
  twitter: {
    card: "summary_large_image",
    title: siteConfig.name,
    description: siteConfig.description,
    images: [`${siteConfig.url}/og.jpg`],
    creator: "@0xZales",
  },
  icons: {
    icon: "/icon.ico",
    shortcut: "/favicon-16x16.png",
    apple: "/apple-touch-icon.png",
  },
}

export default function RootLayout({
  children,
}) {
  return (
    <html lang="en">
      <body className={`${inter.className}   relative sm:-8 p-4 bg-[#13131a] min-h-screen flex flex-row `}>
        <Provider>
          <div className="sm:flex hidden mr-10 relative">
            <Sidebar />
          </div>
          {/* <Sidebar /> */}
          <div className="flex-1 max-sm:w-full max-w-[1280px] mx-auto sm:pr-5  flex flex-col">

            <Navbar />
            {children}
            <footer className='text-white '>
          <div className="container flex flex-col items-center justify-between gap-4 py-10 md:h-24 md:flex-row md:py-0">
            <div className="flex flex-col items-center gap-4 px-8 md:flex-row md:gap-2 md:px-0">
              <Icon imgUrl={'assets/logo.svg'} styles="w-[52px] h-[52px] bg-[#2c2f32]" />
              <p className="text-center text-sm leading-loose md:text-left">
                built_by {" "}
                <a
                  href={siteConfig.links.twitter}
                  target="_blank"
                  rel="noreferrer"
                  className="font-medium underline underline-offset-4"
                >
                  Rozales
                </a>
                
                . The source code is available on{" "}
                <a
                  href={siteConfig.links.github}
                  target="_blank"
                  rel="noreferrer"
                  className="font-medium underline underline-offset-4"
                >
                  GitHub
                </a>
                .
              </p>
            </div>
          </div>
        </footer>
          </div>
        </Provider>
      
      </body>
    </html>
  )
}
